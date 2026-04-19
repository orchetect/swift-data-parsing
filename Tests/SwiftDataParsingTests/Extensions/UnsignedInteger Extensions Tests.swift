//
//  UnsignedInteger Extensions Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftDataParsing
import Testing

@Suite
struct UnsignedInteger_Extensions_Tests {
    @Test
    func uInt8_bit() {
        #expect(UInt8(0b0000_0100).bit(0) == 0)
        #expect(UInt8(0b0000_0100).bit(1) == 0)
        #expect(UInt8(0b0000_0100).bit(2) == 1)
        #expect(UInt8(0b1000_0000).bit(7) == 1)
    }

    @Test
    func uInt16_bit() {
        #expect(UInt16(0b0000_0000_0000_0100).bit(0) == 0)
        #expect(UInt16(0b0000_0000_0000_0100).bit(1) == 0)
        #expect(UInt16(0b0000_0000_0000_0100).bit(2) == 1)
        #expect(UInt16(0b1000_0000_0000_0000).bit(15) == 1)
    }

    @Test
    func uInt32_bit() async {
        #expect(UInt32(0b00000000_00000000_00000000_00000100).bit(0) == 0)
        #expect(UInt32(0b00000000_00000000_00000000_00000100).bit(1) == 0)
        #expect(UInt32(0b00000000_00000000_00000000_00000100).bit(2) == 1)
        #expect(UInt32(0b10000000_00000000_00000000_00000000).bit(31) == 1)
    }

    #if !(arch(arm) || arch(arm64_32) || arch(i386))
    @Test
    func uInt64_bit() async {
        #expect(UInt64(0b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000100).bit(0) == 0)
        #expect(UInt64(0b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000100).bit(1) == 0)
        #expect(UInt64(0b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000100).bit(2) == 1)
        #expect(UInt64(0b10000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000).bit(63) == 1)
    }
    #endif
}
