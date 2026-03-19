//
//  SignedInteger Decoding.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension SignedInteger where Self: FixedWidthInteger, Self: EncodableToUnsignedInteger {
    /// Decode a signed integer from a byte encoded with the specified encoding format.
    public init(decoding source: EncodedInteger, as encoding: SignedIntegerEncoding) {
        lazy var signBit = source.signBit
        
        switch encoding {
        case .signedBit: // for Int8: -128 ... 0 ... 127
            // signed integer types use signed bit encoding by default
            self.init(bitPattern: source)
            return
            
        case .onesComplement: // for Int8: -127 ... -0, +0 ... 127
            switch signBit {
            case 0b0: // positive
                // For +ve numbers the representation rules are the same as signed integer representation.
                precondition(source < (EncodedInteger(Self.max) + 1)) // make sure value will fit
                self.init(bitPattern: source.nonSignBits)
                return
                
            case 0b1: // negative
                // For -ve numbers, use the +ve binary and take 1's complement
                let nsb = source.nonSignBits
                self = Self(nsb) - Self(EncodedInteger.nonSignBitsMask)
                return
                
            default:
                fatalError("Encountered unexpected signum.")
            }
            
            
        case .twosComplement:
            switch signBit {
            case 0b0: // positive
                // For +ve numbers the representation rules are the same as signed integer representation.
                precondition(source < (EncodedInteger(Self.max) + 1)) // make sure value will fit
                self.init(bitPattern: source.nonSignBits)
                return
                
            case 0b1: // negative
                // For -ve numbers, use the +ve binary and take 2's complement
                let nsb = Self(source.nonSignBits)
                self = -(Self(EncodedInteger.nonSignBitsMask) - nsb) - 1
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
