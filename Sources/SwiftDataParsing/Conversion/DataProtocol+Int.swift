//
//  DataProtocol+Int.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol

// MARK: - Int

extension DataProtocol {
    /// Returns an Int64 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt(from byteOrder: ByteOrder = .platformDefault) -> Int? {
        toNumber(from: byteOrder, toType: Int.self)
    }
}

// MARK: - Int8

extension DataProtocol {
    /// Returns an Int8 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt8(from encoding: SignedIntegerEncoding = .signedBit) -> Int8? {
        guard count == 1 else {
            assertionFailure("Data byte length is incorrect. Expected 1 byte but got \(count).")
            return nil
        }
        
        var byte = UInt8()
        withUnsafeMutableBytes(of: &byte) {
            _ = self.copyBytes(to: $0, count: 1)
        }
        
        return Int8(byte, encoding: encoding)
    }
}

extension Int8 {
    /// Decode a signed integer from a byte encoded with the specified encoding format.
    public init(_ byte: UInt8, encoding: SignedIntegerEncoding) {
        lazy var signBit = (byte & 0b1000_0000) >> 7
        
        switch encoding {
        case .signedBit: // -128 ... 0 ... 127
            // signed integer types use signed bit encoding by default
            self.init(bitPattern: byte)
            return
            
        case .onesComplement: // -127 ... -0, +0 ... 127
            switch signBit {
            case 0b0: // positive
                // For +ve numbers the representation rules are the same as signed integer representation.
                precondition(byte < 128)
                self.init(bitPattern: byte & 0b0111_1111)
                return
                
            case 0b1: // negative
                // For -ve numbers, use the +ve binary and take 1's complement
                let magnitude = byte & 0b0111_1111
                self = Int8(magnitude) - 0b0111_1111
                return
                
            default:
                fatalError("Encountered unexpected signum.")
            }
            
            
        case .twosComplement:
            switch signBit {
            case 0b0: // positive
                // For +ve numbers the representation rules are the same as signed integer representation.
                precondition(byte < 128)
                self.init(bitPattern: byte & 0b0111_1111)
                return
                
            case 0b1: // negative
                // For -ve numbers, use the +ve binary and take 2's complement
                let magnitude = Int8(byte & 0b0111_1111)
                self = -(0b111_1111 - magnitude) - 1
                return
            default:
                fatalError("Encountered unexpected signum.")
            }
        }
    }
}

// MARK: - Int16

extension DataProtocol {
    /// Returns an Int16 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt16(from byteOrder: ByteOrder = .platformDefault) -> Int16? {
        toNumber(from: byteOrder, toType: Int16.self)
    }
}

// MARK: - Int32

extension DataProtocol {
    /// Returns an Int32 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt32(from byteOrder: ByteOrder = .platformDefault) -> Int32? {
        toNumber(from: byteOrder, toType: Int32.self)
    }
}

// MARK: - Int64

extension DataProtocol {
    /// Returns an Int64 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt64(from byteOrder: ByteOrder = .platformDefault) -> Int64? {
        toNumber(from: byteOrder, toType: Int64.self)
    }
}

// MARK: - Int128

// TODO: Add Int128 on supported platforms

#endif
