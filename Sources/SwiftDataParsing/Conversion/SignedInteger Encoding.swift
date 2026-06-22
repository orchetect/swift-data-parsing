//
//  SignedInteger Encoding.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension UnsignedInteger where Self: FixedWidthInteger, Self: DecodableFromSignedInteger {
    /// Encode a signed integer using the specified encoding format.
    public init(encoding source: DecodedInteger, as encoding: SignedIntegerEncoding) {
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

// MARK: - Encode Signed Integer to Unsigned Integer

extension Int {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt(as encoding: SignedIntegerEncoding = .signedBit) -> UInt {
        UInt(encoding: self, as: encoding)
    }
}

extension Int8 {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt8(as encoding: SignedIntegerEncoding = .signedBit) -> UInt8 {
        UInt8(encoding: self, as: encoding)
    }
}

extension Int16 {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt16(as encoding: SignedIntegerEncoding = .signedBit) -> UInt16 {
        UInt16(encoding: self, as: encoding)
    }
}

extension Int32 {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt32(as encoding: SignedIntegerEncoding = .signedBit) -> UInt32 {
        UInt32(encoding: self, as: encoding)
    }
}

extension Int64 {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt64(as encoding: SignedIntegerEncoding = .signedBit) -> UInt64 {
        UInt64(encoding: self, as: encoding)
    }
}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension Int128 {
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt128(as encoding: SignedIntegerEncoding = .signedBit) -> UInt128 {
        UInt128(encoding: self, as: encoding)
    }
}

// MARK: - Encode Signed Integer to Data

#if canImport(Foundation)

import struct Foundation.Data
import protocol Foundation.DataProtocol

extension SignedInteger where Self: EncodableToUnsignedInteger,
    EncodedInteger: DecodableFromSignedInteger,
    EncodedInteger.DecodedInteger == Self
{
    /// Returns `Data` representation of a signed integer.
    @_disfavoredOverload
    public func toData(
        _ byteOrder: ByteOrder = .platformDefault,
        as encoding: SignedIntegerEncoding = .signedBit
    ) -> Data {
        EncodedInteger(encoding: self, as: encoding)
            .toData(byteOrder)
    }
}

#endif
