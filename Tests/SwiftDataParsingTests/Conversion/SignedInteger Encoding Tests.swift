//
//  SignedInteger Encoding Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftDataParsing
import Testing

@Suite struct SignedInteger_Encoding_Tests {
    @Test
    func uInt8_fromSignedInteger_signedBitEncoding() async {
        #expect(UInt8(encoding: Int8(-128), as: .signedBit) == 0b1000_0000)
        #expect(UInt8(encoding: Int8(-127), as: .signedBit) == 0b1000_0001)
        #expect(UInt8(encoding: Int8(-2), as: .signedBit) == 0b1111_1110)
        #expect(UInt8(encoding: Int8(-1), as: .signedBit) == 0b1111_1111)
        #expect(UInt8(encoding: Int8(-0), as: .signedBit) == 0b0000_0000)
        #expect(UInt8(encoding: Int8(0), as: .signedBit) == 0b0000_0000)
        #expect(UInt8(encoding: Int8(1), as: .signedBit) == 0b0000_0001)
        #expect(UInt8(encoding: Int8(2), as: .signedBit) == 0b0000_0010)
        #expect(UInt8(encoding: Int8(126), as: .signedBit) == 0b0111_1110)
        #expect(UInt8(encoding: Int8(127), as: .signedBit) == 0b0111_1111)
    }
    
    @Test
    func uInt8_fromSignedInteger_onesComplementEncoding() async {
        #expect(UInt8(encoding: Int8(-127), as: .onesComplement) == 0b1000_0000)
        #expect(UInt8(encoding: Int8(-126), as: .onesComplement) == 0b1000_0001)
        #expect(UInt8(encoding: Int8(-2), as: .onesComplement) == 0b1111_1101)
        #expect(UInt8(encoding: Int8(-1), as: .onesComplement) == 0b1111_1110)
        #expect(UInt8(encoding: Int8(-0), as: .onesComplement) == 0b0000_0000) // (+0 encoding; Int8 can't differentiate)
        #expect(UInt8(encoding: Int8(0), as: .onesComplement) == 0b0000_0000)
        #expect(UInt8(encoding: Int8(1), as: .onesComplement) == 0b0000_0001)
        #expect(UInt8(encoding: Int8(2), as: .onesComplement) == 0b0000_0010)
        #expect(UInt8(encoding: Int8(126), as: .onesComplement) == 0b0111_1110)
        #expect(UInt8(encoding: Int8(127), as: .onesComplement) == 0b0111_1111)
    }
    
    @Test
    func uInt8_fromSignedInteger_twosComplementEncoding() async {
        #expect(UInt8(encoding: Int8(-128), as: .twosComplement) == 0b1000_0000)
        #expect(UInt8(encoding: Int8(-127), as: .twosComplement) == 0b1000_0001)
        #expect(UInt8(encoding: Int8(-1), as: .twosComplement) == 0b1111_1111)
        #expect(UInt8(encoding: Int8(-0), as: .twosComplement) == 0b0000_0000)
        #expect(UInt8(encoding: Int8(0), as: .twosComplement) == 0b0000_0000)
        #expect(UInt8(encoding: Int8(1), as: .twosComplement) == 0b0000_0001)
        #expect(UInt8(encoding: Int8(2), as: .twosComplement) == 0b0000_0010)
        #expect(UInt8(encoding: Int8(126), as: .twosComplement) == 0b0111_1110)
        #expect(UInt8(encoding: Int8(127), as: .twosComplement) == 0b0111_1111)
    }
}
