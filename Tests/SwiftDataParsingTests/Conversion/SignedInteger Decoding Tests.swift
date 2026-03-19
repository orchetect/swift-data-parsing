//
//  SignedInteger Decoding Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftDataParsing
import Testing

@Suite struct SignedInteger_Decoding_Tests {
    // MARK: - Int8
    
    @Test
    func int8_decoding_signedBit() async {
        #expect(Int8(decoding: UInt8(0b1000_0000), as: .signedBit) == -128)
        #expect(Int8(decoding: UInt8(0b1000_0001), as: .signedBit) == -127)
        #expect(Int8(decoding: UInt8(0b1111_1110), as: .signedBit) == -2)
        #expect(Int8(decoding: UInt8(0b1111_1111), as: .signedBit) == -1)
        #expect(Int8(decoding: UInt8(0b0000_0000), as: .signedBit) == -0)
        #expect(Int8(decoding: UInt8(0b0000_0000), as: .signedBit) == 0)
        #expect(Int8(decoding: UInt8(0b0000_0001), as: .signedBit) == 1)
        #expect(Int8(decoding: UInt8(0b0000_0010), as: .signedBit) == 2)
        #expect(Int8(decoding: UInt8(0b0111_1110), as: .signedBit) == 126)
        #expect(Int8(decoding: UInt8(0b0111_1111), as: .signedBit) == 127)
    }
    
    @Test
    func int8_decoding_onesComplement() async {
        #expect(Int8(decoding: UInt8(0b1000_0000), as: .onesComplement) == -127)
        #expect(Int8(decoding: UInt8(0b1000_0001), as: .onesComplement) == -126)
        #expect(Int8(decoding: UInt8(0b1111_1101), as: .onesComplement) == -2)
        #expect(Int8(decoding: UInt8(0b1111_1110), as: .onesComplement) == -1)
        #expect(Int8(decoding: UInt8(0b1111_1111), as: .onesComplement) == -0)
        #expect(Int8(decoding: UInt8(0b0000_0000), as: .onesComplement) == 0)
        #expect(Int8(decoding: UInt8(0b0000_0001), as: .onesComplement) == 1)
        #expect(Int8(decoding: UInt8(0b0000_0010), as: .onesComplement) == 2)
        #expect(Int8(decoding: UInt8(0b0111_1110), as: .onesComplement) == 126)
        #expect(Int8(decoding: UInt8(0b0111_1111), as: .onesComplement) == 127)
    }
    
    @Test
    func int8_decoding_twosComplement() async {
        #expect(Int8(decoding: UInt8(0b1000_0000), as: .twosComplement) == -128)
        #expect(Int8(decoding: UInt8(0b1000_0001), as: .twosComplement) == -127)
        #expect(Int8(decoding: UInt8(0b1111_1110), as: .twosComplement) == -2)
        #expect(Int8(decoding: UInt8(0b1111_1111), as: .twosComplement) == -1)
        #expect(Int8(decoding: UInt8(0b0000_0000), as: .twosComplement) == -0)
        #expect(Int8(decoding: UInt8(0b0000_0000), as: .twosComplement) == 0)
        #expect(Int8(decoding: UInt8(0b0000_0001), as: .twosComplement) == 1)
        #expect(Int8(decoding: UInt8(0b0000_0010), as: .twosComplement) == 2)
        #expect(Int8(decoding: UInt8(0b0111_1110), as: .twosComplement) == 126)
        #expect(Int8(decoding: UInt8(0b0111_1111), as: .twosComplement) == 127)
    }
    
    // MARK: - Int16
    
    @Test
    func int16_decoding_signedBit() async {
        #expect(Int16(decoding: UInt16(0b1000_0000_0000_0000), as: .signedBit) == -32768)
        #expect(Int16(decoding: UInt16(0b1000_0000_0000_0001), as: .signedBit) == -32767)
        #expect(Int16(decoding: UInt16(0b1111_1111_1111_1110), as: .signedBit) == -2)
        #expect(Int16(decoding: UInt16(0b1111_1111_1111_1111), as: .signedBit) == -1)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0000), as: .signedBit) == -0)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0000), as: .signedBit) == 0)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0001), as: .signedBit) == 1)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0010), as: .signedBit) == 2)
        #expect(Int16(decoding: UInt16(0b0111_1111_1111_1110), as: .signedBit) == 32766)
        #expect(Int16(decoding: UInt16(0b0111_1111_1111_1111), as: .signedBit) == 32767)
    }
    
    @Test
    func int16_decoding_onesComplement() async {
        #expect(Int16(decoding: UInt16(0b1000_0000_0000_0000), as: .onesComplement) == -32767)
        #expect(Int16(decoding: UInt16(0b1000_0000_0000_0001), as: .onesComplement) == -32766)
        #expect(Int16(decoding: UInt16(0b1111_1111_1111_1101), as: .onesComplement) == -2)
        #expect(Int16(decoding: UInt16(0b1111_1111_1111_1110), as: .onesComplement) == -1)
        #expect(Int16(decoding: UInt16(0b1111_1111_1111_1111), as: .onesComplement) == -0)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0000), as: .onesComplement) == 0)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0001), as: .onesComplement) == 1)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0010), as: .onesComplement) == 2)
        #expect(Int16(decoding: UInt16(0b0111_1111_1111_1110), as: .onesComplement) == 32766)
        #expect(Int16(decoding: UInt16(0b0111_1111_1111_1111), as: .onesComplement) == 32767)
    }
    
    @Test
    func int16_decoding_twosComplement() async {
        #expect(Int16(decoding: UInt16(0b1000_0000_0000_0000), as: .twosComplement) == -32768)
        #expect(Int16(decoding: UInt16(0b1000_0000_0000_0001), as: .twosComplement) == -32767)
        #expect(Int16(decoding: UInt16(0b1111_1111_1111_1110), as: .twosComplement) == -2)
        #expect(Int16(decoding: UInt16(0b1111_1111_1111_1111), as: .twosComplement) == -1)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0000), as: .twosComplement) == -0)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0000), as: .twosComplement) == 0)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0001), as: .twosComplement) == 1)
        #expect(Int16(decoding: UInt16(0b0000_0000_0000_0010), as: .twosComplement) == 2)
        #expect(Int16(decoding: UInt16(0b0111_1111_1111_1110), as: .twosComplement) == 32766)
        #expect(Int16(decoding: UInt16(0b0111_1111_1111_1111), as: .twosComplement) == 32767)
    }
}
