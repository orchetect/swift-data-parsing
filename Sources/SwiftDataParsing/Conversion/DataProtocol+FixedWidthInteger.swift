//
//  DataProtocol+FixedWidthInteger.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation) && canImport(CoreFoundation)

import func CoreFoundation.memcpy // _DarwinFoundation2.memcpy
import struct Foundation.Data
import protocol Foundation.DataProtocol

extension FixedWidthInteger {
    /// Returns Data representation of an integer. (Endianness has no effect on single-byte
    /// integers.)
    @_disfavoredOverload
    public func toData(_ endianness: DataEndianness = .platformDefault) -> Data {
        var int: Self
        
        switch endianness {
        case .littleEndian: int = littleEndian
        case .bigEndian: int = bigEndian
        }
        
        return withUnsafeBytes(of: &int) { rawBuffer in
            rawBuffer.withMemoryRebound(to: UInt8.self) { buffer in
                Data(buffer: buffer)
            }
        }
    }
}

extension DataProtocol {
    /// Utility method to convert data bytes to a fixed width integer.
    func toNumber<T: FixedWidthInteger>(
        from endianness: DataEndianness = .platformDefault,
        toType: T.Type
    ) -> T? {
        guard count == MemoryLayout<T>.size else { return nil }
        
        // define conversion
        
        // this crashes if Data alignment isn't correct
        // let int: T = { self.withUnsafeBytes { $0.load(as: T.self) } }()
        
        // since load(as:) is not memory alignment safe, memcpy is the current workaround
        // see for more info: https://bugs.swift.org/browse/SR-10273
        guard let int: T = if let self = self as? Data {
            self.withUnsafeBytes({
                var value = T()
                memcpy(&value, $0.baseAddress!, MemoryLayout<T>.size)
                return value
            })
        } else if let self = self as? [UInt8] {
            self.withUnsafeBytes({
                var value = T()
                memcpy(&value, $0.baseAddress!, MemoryLayout<T>.size)
                return value
            })
        } else {
            self.withContiguousStorageIfAvailable({
                var value = T()
                memcpy(&value, $0.baseAddress!, MemoryLayout<T>.size)
                return value
            })
        } else {
            return nil
        }
        
        // determine which conversion is needed
        
        switch endianness {
        case .littleEndian:
            switch DataEndianness.platformDefault {
            case .littleEndian:
                return int
            case .bigEndian:
                return int.byteSwapped
            }
            
        case .bigEndian:
            switch DataEndianness.platformDefault {
            case .littleEndian:
                return int.byteSwapped
            case .bigEndian:
                return int
            }
        }
    }
}

#endif
