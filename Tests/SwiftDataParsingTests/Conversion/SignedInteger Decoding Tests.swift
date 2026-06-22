//
//  SignedInteger Decoding Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftDataParsing
import Testing

@Suite
struct SignedInteger_Decoding_Tests {
    // MARK: - Int8

    @Test
    func int8_decoding_signedBit() {
        #expect(Int8(decoding: UInt8(0b10000000), as: .signedBit) == -128)
        #expect(Int8(decoding: UInt8(0b10000001), as: .signedBit) == -127)
        #expect(Int8(decoding: UInt8(0b11111110), as: .signedBit) == -2)
        #expect(Int8(decoding: UInt8(0b11111111), as: .signedBit) == -1)
        #expect(Int8(decoding: UInt8(0b00000000), as: .signedBit) == -0)
        #expect(Int8(decoding: UInt8(0b00000000), as: .signedBit) == 0)
        #expect(Int8(decoding: UInt8(0b00000001), as: .signedBit) == 1)
        #expect(Int8(decoding: UInt8(0b00000010), as: .signedBit) == 2)
        #expect(Int8(decoding: UInt8(0b01111110), as: .signedBit) == 126)
        #expect(Int8(decoding: UInt8(0b01111111), as: .signedBit) == 127)
    }

    @Test
    func int8_decoding_onesComplement() {
        #expect(Int8(decoding: UInt8(0b10000000), as: .onesComplement) == -127)
        #expect(Int8(decoding: UInt8(0b10000001), as: .onesComplement) == -126)
        #expect(Int8(decoding: UInt8(0b11111101), as: .onesComplement) == -2)
        #expect(Int8(decoding: UInt8(0b11111110), as: .onesComplement) == -1)
        #expect(Int8(decoding: UInt8(0b11111111), as: .onesComplement) == -0)
        #expect(Int8(decoding: UInt8(0b00000000), as: .onesComplement) == 0)
        #expect(Int8(decoding: UInt8(0b00000001), as: .onesComplement) == 1)
        #expect(Int8(decoding: UInt8(0b00000010), as: .onesComplement) == 2)
        #expect(Int8(decoding: UInt8(0b01111110), as: .onesComplement) == 126)
        #expect(Int8(decoding: UInt8(0b01111111), as: .onesComplement) == 127)
    }

    @Test
    func int8_decoding_twosComplement() {
        #expect(Int8(decoding: UInt8(0b10000000), as: .twosComplement) == -128)
        #expect(Int8(decoding: UInt8(0b10000001), as: .twosComplement) == -127)
        #expect(Int8(decoding: UInt8(0b11111110), as: .twosComplement) == -2)
        #expect(Int8(decoding: UInt8(0b11111111), as: .twosComplement) == -1)
        #expect(Int8(decoding: UInt8(0b00000000), as: .twosComplement) == -0)
        #expect(Int8(decoding: UInt8(0b00000000), as: .twosComplement) == 0)
        #expect(Int8(decoding: UInt8(0b00000001), as: .twosComplement) == 1)
        #expect(Int8(decoding: UInt8(0b00000010), as: .twosComplement) == 2)
        #expect(Int8(decoding: UInt8(0b01111110), as: .twosComplement) == 126)
        #expect(Int8(decoding: UInt8(0b01111111), as: .twosComplement) == 127)
    }

    // MARK: - Int16

    @Test
    func int16_decoding_signedBit() {
        #expect(Int16(decoding: UInt16(0b10000000_00000000), as: .signedBit) == -32768)
        #expect(Int16(decoding: UInt16(0b10000000_00000001), as: .signedBit) == -32767)
        #expect(Int16(decoding: UInt16(0b11111111_11111110), as: .signedBit) == -2)
        #expect(Int16(decoding: UInt16(0b11111111_11111111), as: .signedBit) == -1)
        #expect(Int16(decoding: UInt16(0b00000000_00000000), as: .signedBit) == -0)
        #expect(Int16(decoding: UInt16(0b00000000_00000000), as: .signedBit) == 0)
        #expect(Int16(decoding: UInt16(0b00000000_00000001), as: .signedBit) == 1)
        #expect(Int16(decoding: UInt16(0b00000000_00000010), as: .signedBit) == 2)
        #expect(Int16(decoding: UInt16(0b01111111_11111110), as: .signedBit) == 32766)
        #expect(Int16(decoding: UInt16(0b01111111_11111111), as: .signedBit) == 32767)
    }

    @Test
    func int16_decoding_onesComplement() {
        #expect(Int16(decoding: UInt16(0b10000000_00000000), as: .onesComplement) == -32767)
        #expect(Int16(decoding: UInt16(0b10000000_00000001), as: .onesComplement) == -32766)
        #expect(Int16(decoding: UInt16(0b11111111_11111101), as: .onesComplement) == -2)
        #expect(Int16(decoding: UInt16(0b11111111_11111110), as: .onesComplement) == -1)
        #expect(Int16(decoding: UInt16(0b11111111_11111111), as: .onesComplement) == -0)
        #expect(Int16(decoding: UInt16(0b00000000_00000000), as: .onesComplement) == 0)
        #expect(Int16(decoding: UInt16(0b00000000_00000001), as: .onesComplement) == 1)
        #expect(Int16(decoding: UInt16(0b00000000_00000010), as: .onesComplement) == 2)
        #expect(Int16(decoding: UInt16(0b01111111_11111110), as: .onesComplement) == 32766)
        #expect(Int16(decoding: UInt16(0b01111111_11111111), as: .onesComplement) == 32767)
    }

    @Test
    func int16_decoding_twosComplement() {
        #expect(Int16(decoding: UInt16(0b10000000_00000000), as: .twosComplement) == -32768)
        #expect(Int16(decoding: UInt16(0b10000000_00000001), as: .twosComplement) == -32767)
        #expect(Int16(decoding: UInt16(0b11111111_11111110), as: .twosComplement) == -2)
        #expect(Int16(decoding: UInt16(0b11111111_11111111), as: .twosComplement) == -1)
        #expect(Int16(decoding: UInt16(0b00000000_00000000), as: .twosComplement) == -0)
        #expect(Int16(decoding: UInt16(0b00000000_00000000), as: .twosComplement) == 0)
        #expect(Int16(decoding: UInt16(0b00000000_00000001), as: .twosComplement) == 1)
        #expect(Int16(decoding: UInt16(0b00000000_00000010), as: .twosComplement) == 2)
        #expect(Int16(decoding: UInt16(0b01111111_11111110), as: .twosComplement) == 32766)
        #expect(Int16(decoding: UInt16(0b01111111_11111111), as: .twosComplement) == 32767)
    }
}
