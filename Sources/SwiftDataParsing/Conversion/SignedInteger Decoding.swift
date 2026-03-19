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

extension Int {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt(_ encoding: SignedIntegerEncoding = .signedBit) -> UInt {
        UInt(decoding: self, as: encoding)
    }
}

extension Int8 {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt8(_ encoding: SignedIntegerEncoding = .signedBit) -> UInt8 {
        UInt8(decoding: self, as: encoding)
    }
}

extension Int16 {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt16(_ encoding: SignedIntegerEncoding = .signedBit) -> UInt16 {
        UInt16(decoding: self, as: encoding)
    }
}

extension Int32 {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt32(_ encoding: SignedIntegerEncoding = .signedBit) -> UInt32 {
        UInt32(decoding: self, as: encoding)
    }
}

extension Int64 {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt64(_ encoding: SignedIntegerEncoding = .signedBit) -> UInt64 {
        UInt64(decoding: self, as: encoding)
    }
}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension Int128 {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt128(_ encoding: SignedIntegerEncoding = .signedBit) -> UInt128 {
        UInt128(decoding: self, as: encoding)
    }
}
