//
//  Int8+UInt8.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

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
    
    /// Encode a signed integer using the specified encoding format.
    @_disfavoredOverload
    public func toUInt8(_ encoding: SignedIntegerEncoding = .signedBit) -> UInt8 {
        UInt8(self, encoding: encoding)
    }
}
