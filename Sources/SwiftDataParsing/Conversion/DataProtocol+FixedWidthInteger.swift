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
    /// Returns `Data` representation of an integer.
    /// (Byte order has no effect on single-byte integers.)
    @_disfavoredOverload
    public func toData(_ byteOrder: ByteOrder = .platformDefault) -> Data {
        var int: Self = switch byteOrder {
        case .littleEndian: littleEndian
        case .bigEndian: bigEndian
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
        from byteOrder: ByteOrder,
        toType: T.Type
    ) -> T? {
        let expectedByteLength = MemoryLayout<T>.size
        guard count == expectedByteLength else {
            assertionFailure("Data byte length is incorrect. Expected \(expectedByteLength) bytes but got \(count).")
            return nil
        }
        
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
        
        return switch byteOrder {
        case .littleEndian:
            switch ByteOrder.platformDefault {
            case .littleEndian: int
            case .bigEndian: int.byteSwapped
            }
            
        case .bigEndian:
            switch ByteOrder.platformDefault {
            case .littleEndian: int.byteSwapped
            case .bigEndian: int
            }
        }
    }
}

extension DataProtocol {
    /// Utility method to convert data bytes to a fixed width integer.
    func toNumber<T: FixedWidthInteger>(
        from byteOrder: ByteOrder,
        toType: T.Type,
        as encoding: SignedIntegerEncoding
    ) -> T? where T: SignedInteger, T: EncodableToUnsignedInteger {
        guard let uint = toNumber(from: byteOrder, toType: T.EncodedInteger.self) else { return nil }
        return T(decoding: uint, as: encoding)
    }
}

#endif
