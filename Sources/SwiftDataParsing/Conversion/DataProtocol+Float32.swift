//
//  DataProtocol+Float32.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation) && canImport(CoreFoundation)

import func CoreFoundation.CFConvertFloat32SwappedToHost
import struct CoreFoundation.CFSwappedFloat32
import func CoreFoundation.memcpy // _DarwinFoundation2.memcpy
import struct Foundation.Data
import protocol Foundation.DataProtocol

extension Float32 {
    /// Returns Data representation of a Float32 value.
    @_disfavoredOverload
    public func toData(_ endianness: DataEndianness = .platformDefault) -> Data {
        var number = self
        
        return withUnsafeBytes(of: &number) { rawBuffer in
            rawBuffer.withMemoryRebound(to: UInt8.self) { buffer in
                switch endianness {
                case .littleEndian:
                    switch DataEndianness.platformDefault {
                    case .littleEndian:
                        return Data(buffer: buffer)
                    case .bigEndian:
                        return Data(Data(buffer: buffer).reversed())
                    }
                    
                case .bigEndian:
                    switch DataEndianness.platformDefault {
                    case .littleEndian:
                        return Data(Data(buffer: buffer).reversed())
                    case .bigEndian:
                        return Data(buffer: buffer)
                    }
                }
            }
        }
    }
}

extension DataProtocol {
    /// Returns a Float32 value from Data.
    /// Returns `nil` if Data is != 4 bytes.
    @_disfavoredOverload
    public func toFloat32(from endianness: DataEndianness = .platformDefault) -> Float32? {
        guard count == 4 else { return nil }
        
        // define conversions
        
        // this crashes if Data alignment isn't correct
        // let number = { self.withUnsafeBytes { $0.load(as: Float32.self) } }()
        
        // since load(as:) is not memory alignment safe, memcpy is the current workaround
        // see for more info: https://bugs.swift.org/browse/SR-10273
        
        func number() -> Float32? {
            if let self = self as? Data {
                self.withUnsafeBytes({
                    var value = Float32()
                    memcpy(&value, $0.baseAddress!, 4)
                    return value
                })
            } else if let self = self as? [UInt8] {
                self.withUnsafeBytes({
                    var value = Float32()
                    memcpy(&value, $0.baseAddress!, 4)
                    return value
                })
            } else {
                self.withContiguousStorageIfAvailable({
                    var value = Float32()
                    memcpy(&value, $0.baseAddress!, 4)
                    return value
                })
            }
        }
        
        func numberSwapped() -> Float32? {
            guard let swapped: CFSwappedFloat32 = if let self = self as? Data {
                self.withUnsafeBytes({
                    // $0.load(as: CFSwappedFloat32.self)
                    var value = CFSwappedFloat32()
                    memcpy(&value, $0.baseAddress!, 4)
                    return value
                })
            } else if let self = self as? [UInt8] {
                self.withUnsafeBytes({
                    // $0.load(as: CFSwappedFloat32.self)
                    var value = CFSwappedFloat32()
                    memcpy(&value, $0.baseAddress!, 4)
                    return value
                })
            } else {
                self.withContiguousStorageIfAvailable({
                    // $0.load(as: CFSwappedFloat32.self)
                    var value = CFSwappedFloat32()
                    memcpy(&value, $0.baseAddress!, 4)
                    return value
                })
            } else {
                return nil
            }
            return CFConvertFloat32SwappedToHost(swapped)
        }
        
        // determine which conversion is needed
        
        return switch endianness {
        case .littleEndian:
            switch DataEndianness.platformDefault {
            case .littleEndian: number()
            case .bigEndian: numberSwapped()
            }
            
        case .bigEndian:
            switch DataEndianness.platformDefault {
            case .littleEndian: numberSwapped()
            case .bigEndian: number()
            }
        }
    }
}

#endif
