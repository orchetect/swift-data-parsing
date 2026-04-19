//
//  FixedWidthInteger Extensions Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftDataParsing
import Testing

@Suite
struct FixedWidthInteger_Extensions_Tests {
    @Test
    func signBit() {
        #expect(UInt8(0b0000_0000).signBit == 0)
        #expect(UInt8(0b1000_0000).signBit == 1)

        #expect(UInt16(0b0000_0000_0000_0000).signBit == 0)
        #expect(UInt16(0b1000_0000_0000_0000).signBit == 1)
        
        #expect(UInt32(0b00000000_00000000_00000000_00000000).signBit == 0)
        #expect(UInt32(0b10000000_00000000_00000000_00000000).signBit == 1)
        
        #expect(UInt64(0b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000).signBit == 0)
        #expect(UInt64(0b10000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000).signBit == 1)
    }

    @Test
    func signBitMask() {
        #expect(UInt8.signBitMask == 0b1000_0000)

        #expect(UInt16.signBitMask == 0b1000_0000_0000_0000)
        
        #expect(UInt32.signBitMask == 0b10000000_00000000_00000000_00000000)
        
        #expect(UInt64.signBitMask == 0b10000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000)
    }

    @Test
    func nonSignBits() {
        #expect(UInt8(0b0000_0000).nonSignBits == 0)
        #expect(UInt8(0b1000_0000).nonSignBits == 0)
        #expect(UInt8(0b0111_1111).nonSignBits == 0b0111_1111)
        #expect(UInt8(0b1111_1111).nonSignBits == 0b0111_1111)

        #expect(UInt16(0b0000_0000_0000_0000).nonSignBits == 0)
        #expect(UInt16(0b1000_0000_0000_0000).nonSignBits == 0)
        #expect(UInt16(0b0111_1111_1111_1111).nonSignBits == 0b0111_1111_1111_1111)
        #expect(UInt16(0b1111_1111_1111_1111).nonSignBits == 0b0111_1111_1111_1111)
        
        #expect(UInt32(0b00000000_00000000_00000000_00000000).nonSignBits == 0)
        #expect(UInt32(0b10000000_00000000_00000000_00000000).nonSignBits == 0)
        #expect(UInt32(0b01111111_11111111_11111111_11111111).nonSignBits == 0b01111111_11111111_11111111_11111111)
        #expect(UInt32(0b11111111_11111111_11111111_11111111).nonSignBits == 0b01111111_11111111_11111111_11111111)
        
        #expect(
            UInt64(0b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000).nonSignBits
                == 0
        )
        #expect(
            UInt64(0b10000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000).nonSignBits
                == 0
        )
        #expect(
            UInt64(0b01111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111).nonSignBits
                == 0b01111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111
        )
        #expect(
            UInt64(0b11111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111).nonSignBits
                == 0b01111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111
        )
    }

    @Test
    func nonSignBitsMask() {
        #expect(UInt8.nonSignBitsMask == 0b0111_1111)

        #expect(UInt16.nonSignBitsMask == 0b0111_1111_1111_1111)
        
        #expect(UInt32.nonSignBitsMask == 0b01111111_11111111_11111111_11111111)
        
        #expect(UInt64.nonSignBitsMask == 0b01111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111)
    }
}
