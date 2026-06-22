//
//  SignedInteger Encoding Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
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
        #expect(UInt8(encoding: Int8(-128), as: .signedBit) == 0b10000000)
        #expect(UInt8(encoding: Int8(-127), as: .signedBit) == 0b10000001)
        #expect(UInt8(encoding: Int8(-2),   as: .signedBit) == 0b11111110)
        #expect(UInt8(encoding: Int8(-1),   as: .signedBit) == 0b11111111)
        #expect(UInt8(encoding: Int8(-0),   as: .signedBit) == 0b00000000)
        #expect(UInt8(encoding: Int8(0),    as: .signedBit) == 0b00000000)
        #expect(UInt8(encoding: Int8(1),    as: .signedBit) == 0b00000001)
        #expect(UInt8(encoding: Int8(2),    as: .signedBit) == 0b00000010)
        #expect(UInt8(encoding: Int8(126),  as: .signedBit) == 0b01111110)
        #expect(UInt8(encoding: Int8(127),  as: .signedBit) == 0b01111111)
    }

    @Test
    func uInt8_encoding_onesComplement() {
        #expect(UInt8(encoding: Int8(-127), as: .onesComplement) == 0b10000000)
        #expect(UInt8(encoding: Int8(-126), as: .onesComplement) == 0b10000001)
        #expect(UInt8(encoding: Int8(-2),   as: .onesComplement) == 0b11111101)
        #expect(UInt8(encoding: Int8(-1),   as: .onesComplement) == 0b11111110)
        #expect(UInt8(encoding: Int8(-0),   as: .onesComplement) == 0b00000000) // (+0 encoding; Int8 can't differentiate)
        #expect(UInt8(encoding: Int8(0),    as: .onesComplement) == 0b00000000)
        #expect(UInt8(encoding: Int8(1),    as: .onesComplement) == 0b00000001)
        #expect(UInt8(encoding: Int8(2),    as: .onesComplement) == 0b00000010)
        #expect(UInt8(encoding: Int8(126),  as: .onesComplement) == 0b01111110)
        #expect(UInt8(encoding: Int8(127),  as: .onesComplement) == 0b01111111)
    }

    @Test
    func uInt8_encoding_twosComplement() {
        #expect(UInt8(encoding: Int8(-128), as: .twosComplement) == 0b10000000)
        #expect(UInt8(encoding: Int8(-127), as: .twosComplement) == 0b10000001)
        #expect(UInt8(encoding: Int8(-2),   as: .twosComplement) == 0b11111110)
        #expect(UInt8(encoding: Int8(-1),   as: .twosComplement) == 0b11111111)
        #expect(UInt8(encoding: Int8(-0),   as: .twosComplement) == 0b00000000)
        #expect(UInt8(encoding: Int8(0),    as: .twosComplement) == 0b00000000)
        #expect(UInt8(encoding: Int8(1),    as: .twosComplement) == 0b00000001)
        #expect(UInt8(encoding: Int8(2),    as: .twosComplement) == 0b00000010)
        #expect(UInt8(encoding: Int8(126),  as: .twosComplement) == 0b01111110)
        #expect(UInt8(encoding: Int8(127),  as: .twosComplement) == 0b01111111)
    }

    // MARK: - UInt16

    @Test
    func uInt16_encoding_signedBit() {
        #expect(UInt16(encoding: Int16(-32768), as: .signedBit) == 0b10000000_00000000)
        #expect(UInt16(encoding: Int16(-32767), as: .signedBit) == 0b10000000_00000001)
        #expect(UInt16(encoding: Int16(-2),     as: .signedBit) == 0b11111111_11111110)
        #expect(UInt16(encoding: Int16(-1),     as: .signedBit) == 0b11111111_11111111)
        #expect(UInt16(encoding: Int16(-0),     as: .signedBit) == 0b00000000_00000000)
        #expect(UInt16(encoding: Int16(0),      as: .signedBit) == 0b00000000_00000000)
        #expect(UInt16(encoding: Int16(1),      as: .signedBit) == 0b00000000_00000001)
        #expect(UInt16(encoding: Int16(2),      as: .signedBit) == 0b00000000_00000010)
        #expect(UInt16(encoding: Int16(32766),  as: .signedBit) == 0b01111111_11111110)
        #expect(UInt16(encoding: Int16(32767),  as: .signedBit) == 0b01111111_11111111)
    }

    @Test
    func uInt16_encoding_onesComplement() {
        #expect(UInt16(encoding: Int16(-32767), as: .onesComplement) == 0b10000000_00000000)
        #expect(UInt16(encoding: Int16(-32766), as: .onesComplement) == 0b10000000_00000001)
        #expect(UInt16(encoding: Int16(-2),     as: .onesComplement) == 0b11111111_11111101)
        #expect(UInt16(encoding: Int16(-1),     as: .onesComplement) == 0b11111111_11111110)
        #expect(UInt16(encoding: Int16(-0),     as: .onesComplement) == 0b00000000_00000000) // (+0 encoding; Int8 can't differentiate)
        #expect(UInt16(encoding: Int16(0),      as: .onesComplement) == 0b00000000_00000000)
        #expect(UInt16(encoding: Int16(1),      as: .onesComplement) == 0b00000000_00000001)
        #expect(UInt16(encoding: Int16(2),      as: .onesComplement) == 0b00000000_00000010)
        #expect(UInt16(encoding: Int16(32766),  as: .onesComplement) == 0b01111111_11111110)
        #expect(UInt16(encoding: Int16(32767),  as: .onesComplement) == 0b01111111_11111111)
    }

    @Test
    func uInt16_encoding_twosComplement() {
        #expect(UInt16(encoding: Int16(-32768), as: .twosComplement) == 0b10000000_00000000)
        #expect(UInt16(encoding: Int16(-32767), as: .twosComplement) == 0b10000000_00000001)
        #expect(UInt16(encoding: Int16(-2),     as: .twosComplement) == 0b11111111_11111110)
        #expect(UInt16(encoding: Int16(-1),     as: .twosComplement) == 0b11111111_11111111)
        #expect(UInt16(encoding: Int16(-0),     as: .twosComplement) == 0b00000000_00000000)
        #expect(UInt16(encoding: Int16(0),      as: .twosComplement) == 0b00000000_00000000)
        #expect(UInt16(encoding: Int16(1),      as: .twosComplement) == 0b00000000_00000001)
        #expect(UInt16(encoding: Int16(2),      as: .twosComplement) == 0b00000000_00000010)
        #expect(UInt16(encoding: Int16(32766),  as: .twosComplement) == 0b01111111_11111110)
        #expect(UInt16(encoding: Int16(32767),  as: .twosComplement) == 0b01111111_11111111)
    }
}
