//
//  DataProtocol+Int.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol

// MARK: - UInt

extension DataProtocol {
    /// Returns a UInt value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toUInt(from byteOrder: ByteOrder = .platformDefault) -> UInt? {
        toNumber(from: byteOrder, toType: UInt.self)
    }
}

// MARK: - UInt8

extension DataProtocol {
    /// Returns a UInt8 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toUInt8() -> UInt8? {
        guard count == 1 else {
            assertionFailure("Data byte length is incorrect. Expected 1 byte but got \(count).")
            return nil
        }
        return first
    }
}

extension UInt8 {
    /// Encode a signed integer using the specified encoding format.
    public init(_ signedInteger: Int8, encoding: SignedIntegerEncoding) {
        switch encoding {
        case .signedBit: // -128 ... 0 ... 127
            // signed integer types use signed bit encoding by default
            self.init(bitPattern: signedInteger)
            return
            
        case .onesComplement: // -127 ... -0, +0 ... 127
            switch signedInteger.signum() {
            case 1:
                // For +ve numbers the representation rules are the same as signed integer representation.
                self.init(bitPattern: signedInteger)
                return
                
            case 0:
                // technically 1's complement has -0 and +0, but a signed integer only has one 0 value,
                // so we will prefer the +0 encoding
                self = 0
                return
                
            case -1:
                // For -ve numbers, use the +ve binary and take 1's complement
                precondition(signedInteger > -128)
                self = 0b1000_0000 + ((0b0111_1111 - UInt8(abs(signedInteger)) & 0b0111_1111))
                return
                
            default:
                fatalError("Encountered unexpected signum.")
            }
                
            
        case .twosComplement:
            switch signedInteger.signum() {
            case 1:
                // For +ve numbers the representation rules are the same as signed integer representation.
                self.init(bitPattern: signedInteger)
                return
                
            case 0:
                self = 0
                return
                
            case -1:
                // For -ve numbers, use the +ve binary and take 2's complement
                let absValue = UInt8(abs(Int16(signedInteger))) // need 16-bit signed int to fit value of 128
                let magnitude = UInt8((0b0111_1111 + 1) - absValue)
                self = 0b1000_0000 + (magnitude & 0b0111_1111)
                return
                
            default:
                fatalError("Encountered unexpected signum.")
            }
        }
    }
    
    /// Decode a signed integer from a byte encoded with the specified encoding format.
    @_disfavoredOverload
    public func toInt8(_ encoding: SignedIntegerEncoding = .signedBit) -> Int8 {
        Int8(self, encoding: encoding)
    }
}

// MARK: - UInt16

extension DataProtocol {
    /// Returns a UInt16 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toUInt16(from byteOrder: ByteOrder = .platformDefault) -> UInt16? {
        toNumber(from: byteOrder, toType: UInt16.self)
    }
}

// MARK: - UInt32

extension DataProtocol {
    /// Returns a UInt32 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toUInt32(from byteOrder: ByteOrder = .platformDefault) -> UInt32? {
        toNumber(from: byteOrder, toType: UInt32.self)
    }
}

// MARK: - UInt64

extension DataProtocol {
    /// Returns a UInt64 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toUInt64(from byteOrder: ByteOrder = .platformDefault) -> UInt64? {
        toNumber(from: byteOrder, toType: UInt64.self)
    }
}

// MARK: - UInt128

// TODO: Add UInt128 on supported platforms

#endif
