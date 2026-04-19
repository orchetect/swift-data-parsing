//
//  SignedInteger Encoding Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftDataParsing
import Testing

// swiftformat:disable consecutiveSpaces spaceInsideParens spaceInsideBrackets spaceAroundOperators

@Suite
struct SignedInteger_Encoding_Tests {
    // MARK: - UInt8

    @Test
    func uInt8_encoding_signedBit() {
        #expect(UInt8(encoding: Int8(-128), as: .signedBit) == 0b1000_0000)
        #expect(UInt8(encoding: Int8(-127), as: .signedBit) == 0b1000_0001)
        #expect(UInt8(encoding: Int8(-2),   as: .signedBit) == 0b1111_1110)
        #expect(UInt8(encoding: Int8(-1),   as: .signedBit) == 0b1111_1111)
        #expect(UInt8(encoding: Int8(-0),   as: .signedBit) == 0b0000_0000)
        #expect(UInt8(encoding: Int8(0),    as: .signedBit) == 0b0000_0000)
        #expect(UInt8(encoding: Int8(1),    as: .signedBit) == 0b0000_0001)
        #expect(UInt8(encoding: Int8(2),    as: .signedBit) == 0b0000_0010)
        #expect(UInt8(encoding: Int8(126),  as: .signedBit) == 0b0111_1110)
        #expect(UInt8(encoding: Int8(127),  as: .signedBit) == 0b0111_1111)
    }

    @Test
    func uInt8_encoding_onesComplement() {
        #expect(UInt8(encoding: Int8(-127), as: .onesComplement) == 0b1000_0000)
        #expect(UInt8(encoding: Int8(-126), as: .onesComplement) == 0b1000_0001)
        #expect(UInt8(encoding: Int8(-2),   as: .onesComplement) == 0b1111_1101)
        #expect(UInt8(encoding: Int8(-1),   as: .onesComplement) == 0b1111_1110)
        #expect(UInt8(encoding: Int8(-0),   as: .onesComplement) == 0b0000_0000) // (+0 encoding; Int8 can't differentiate)
        #expect(UInt8(encoding: Int8(0),    as: .onesComplement) == 0b0000_0000)
        #expect(UInt8(encoding: Int8(1),    as: .onesComplement) == 0b0000_0001)
        #expect(UInt8(encoding: Int8(2),    as: .onesComplement) == 0b0000_0010)
        #expect(UInt8(encoding: Int8(126),  as: .onesComplement) == 0b0111_1110)
        #expect(UInt8(encoding: Int8(127),  as: .onesComplement) == 0b0111_1111)
    }

    @Test
    func uInt8_encoding_twosComplement() {
        #expect(UInt8(encoding: Int8(-128), as: .twosComplement) == 0b1000_0000)
        #expect(UInt8(encoding: Int8(-127), as: .twosComplement) == 0b1000_0001)
        #expect(UInt8(encoding: Int8(-2),   as: .twosComplement) == 0b1111_1110)
        #expect(UInt8(encoding: Int8(-1),   as: .twosComplement) == 0b1111_1111)
        #expect(UInt8(encoding: Int8(-0),   as: .twosComplement) == 0b0000_0000)
        #expect(UInt8(encoding: Int8(0),    as: .twosComplement) == 0b0000_0000)
        #expect(UInt8(encoding: Int8(1),    as: .twosComplement) == 0b0000_0001)
        #expect(UInt8(encoding: Int8(2),    as: .twosComplement) == 0b0000_0010)
        #expect(UInt8(encoding: Int8(126),  as: .twosComplement) == 0b0111_1110)
        #expect(UInt8(encoding: Int8(127),  as: .twosComplement) == 0b0111_1111)
    }

    // MARK: - UInt16

    @Test
    func uInt16_encoding_signedBit() {
        #expect(UInt16(encoding: Int16(-32768), as: .signedBit) == 0b1000_0000_0000_0000)
        #expect(UInt16(encoding: Int16(-32767), as: .signedBit) == 0b1000_0000_0000_0001)
        #expect(UInt16(encoding: Int16(-2),     as: .signedBit) == 0b1111_1111_1111_1110)
        #expect(UInt16(encoding: Int16(-1),     as: .signedBit) == 0b1111_1111_1111_1111)
        #expect(UInt16(encoding: Int16(-0),     as: .signedBit) == 0b0000_0000_0000_0000)
        #expect(UInt16(encoding: Int16(0),      as: .signedBit) == 0b0000_0000_0000_0000)
        #expect(UInt16(encoding: Int16(1),      as: .signedBit) == 0b0000_0000_0000_0001)
        #expect(UInt16(encoding: Int16(2),      as: .signedBit) == 0b0000_0000_0000_0010)
        #expect(UInt16(encoding: Int16(32766),  as: .signedBit) == 0b0111_1111_1111_1110)
        #expect(UInt16(encoding: Int16(32767),  as: .signedBit) == 0b0111_1111_1111_1111)
    }

    @Test
    func uInt16_encoding_onesComplement() {
        #expect(UInt16(encoding: Int16(-32767), as: .onesComplement) == 0b1000_0000_0000_0000)
        #expect(UInt16(encoding: Int16(-32766), as: .onesComplement) == 0b1000_0000_0000_0001)
        #expect(UInt16(encoding: Int16(-2),     as: .onesComplement) == 0b1111_1111_1111_1101)
        #expect(UInt16(encoding: Int16(-1),     as: .onesComplement) == 0b1111_1111_1111_1110)
        #expect(UInt16(encoding: Int16(-0),     as: .onesComplement) == 0b0000_0000_0000_0000) // (+0 encoding; Int8 can't differentiate)
        #expect(UInt16(encoding: Int16(0),      as: .onesComplement) == 0b0000_0000_0000_0000)
        #expect(UInt16(encoding: Int16(1),      as: .onesComplement) == 0b0000_0000_0000_0001)
        #expect(UInt16(encoding: Int16(2),      as: .onesComplement) == 0b0000_0000_0000_0010)
        #expect(UInt16(encoding: Int16(32766),  as: .onesComplement) == 0b0111_1111_1111_1110)
        #expect(UInt16(encoding: Int16(32767),  as: .onesComplement) == 0b0111_1111_1111_1111)
    }

    @Test
    func uInt16_encoding_twosComplement() {
        #expect(UInt16(encoding: Int16(-32768), as: .twosComplement) == 0b1000_0000_0000_0000)
        #expect(UInt16(encoding: Int16(-32767), as: .twosComplement) == 0b1000_0000_0000_0001)
        #expect(UInt16(encoding: Int16(-2),     as: .twosComplement) == 0b1111_1111_1111_1110)
        #expect(UInt16(encoding: Int16(-1),     as: .twosComplement) == 0b1111_1111_1111_1111)
        #expect(UInt16(encoding: Int16(-0),     as: .twosComplement) == 0b0000_0000_0000_0000)
        #expect(UInt16(encoding: Int16(0),      as: .twosComplement) == 0b0000_0000_0000_0000)
        #expect(UInt16(encoding: Int16(1),      as: .twosComplement) == 0b0000_0000_0000_0001)
        #expect(UInt16(encoding: Int16(2),      as: .twosComplement) == 0b0000_0000_0000_0010)
        #expect(UInt16(encoding: Int16(32766),  as: .twosComplement) == 0b0111_1111_1111_1110)
        #expect(UInt16(encoding: Int16(32767),  as: .twosComplement) == 0b0111_1111_1111_1111)
    }
}
