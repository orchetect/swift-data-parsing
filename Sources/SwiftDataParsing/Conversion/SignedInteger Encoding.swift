//
//  SignedInteger Encoding.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension UnsignedInteger where Self: FixedWidthInteger, Self: DecodableFromSignedInteger {
    /// Encode a signed integer using the specified encoding format.
    public init(decoding source: DecodedInteger, as encoding: SignedIntegerEncoding) {
        switch encoding {
        case .signedBit: // for Int8: -128 ... 0 ... 127
            // signed integer types use signed bit encoding by default
            self.init(bitPattern: source)
            return
            
        case .onesComplement: // for Int8: -127 ... -0, +0 ... 127
            switch source.signum() {
            case 1:
                // For +ve numbers the representation rules are the same as signed integer representation.
                self.init(bitPattern: source)
                return
                
            case 0:
                // technically 1's complement has -0 and +0, but a signed integer only has one 0 value,
                // so we will prefer the +0 encoding
                self = 0
                return
                
            case -1:
                // For -ve numbers, use the +ve binary and take 1's complement
                precondition(source > DecodedInteger.min)
                self = Self.signBitMask + (Self.nonSignBitsMask - Self(abs(source)).nonSignBits)
                return
                
            default:
                fatalError("Encountered unexpected signum.")
            }
            
            
        case .twosComplement: // for Int8: -128 ... 0 ... 127
            switch source.signum() {
            case 1:
                // For +ve numbers the representation rules are the same as signed integer representation.
                self.init(bitPattern: source)
                return
                
            case 0:
                self = 0
                return
                
            case -1:
                // For -ve numbers, use the +ve binary and take 2's complement
                let absValue = Self(abs(Int(source))) // need larger integer to fit max value
                let magnitude = Self((Self.nonSignBitsMask + 1) - absValue)
                self = Self.signBitMask + (magnitude & Self.nonSignBitsMask)
                return
                
            default:
                fatalError("Encountered unexpected signum.")
            }
        }
    }
}

extension UInt {
    /// Decode a signed integer from a byte encoded with the specified encoding format.
    @_disfavoredOverload
    public func toInt(from encoding: SignedIntegerEncoding = .signedBit) -> Int {
        Int(decoding: self, as: encoding)
    }
}

extension UInt8 {
    /// Decode a signed integer from a byte encoded with the specified encoding format.
    @_disfavoredOverload
    public func toInt8(from encoding: SignedIntegerEncoding = .signedBit) -> Int8 {
        Int8(decoding: self, as: encoding)
    }
}

extension UInt16 {
    /// Decode a signed integer from a byte encoded with the specified encoding format.
    @_disfavoredOverload
    public func toInt16(from encoding: SignedIntegerEncoding = .signedBit) -> Int16 {
        Int16(decoding: self, as: encoding)
    }
}

extension UInt32 {
    /// Decode a signed integer from a byte encoded with the specified encoding format.
    @_disfavoredOverload
    public func toInt32(from encoding: SignedIntegerEncoding = .signedBit) -> Int32 {
        Int32(decoding: self, as: encoding)
    }
}

extension UInt64 {
    /// Decode a signed integer from a byte encoded with the specified encoding format.
    @_disfavoredOverload
    public func toInt64(from encoding: SignedIntegerEncoding = .signedBit) -> Int64 {
        Int64(decoding: self, as: encoding)
    }
}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension UInt128 {
    /// Decode a signed integer from a byte encoded with the specified encoding format.
    @_disfavoredOverload
    public func toInt128(from encoding: SignedIntegerEncoding = .signedBit) -> Int128 {
        Int128(decoding: self, as: encoding)
    }
}
