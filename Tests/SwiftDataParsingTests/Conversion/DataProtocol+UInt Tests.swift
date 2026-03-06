//
//  DataProtocol+UInt Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation
import SwiftDataParsing
import Testing

@Suite struct DataProtocol_UInt_Tests {
    @Test
    func uInt() {
        // UInt is 32-bit on 32-bit systems, 64-bit on 64-bit systems
        #if !(arch(arm) || arch(arm64_32) || arch(i386))

        // .toData

        #expect(UInt(0b1).toData(.littleEndian) == Data([0b1, 0, 0, 0, 0, 0, 0, 0]))
        #expect(UInt(0b1).toData(.bigEndian) == Data([0, 0, 0, 0, 0, 0, 0, 0b1]))

        // .toUInt

        #expect(Data([]).toUInt() == nil) // underflow
        #expect(Data([1]).toUInt() == nil) // underflow
        #expect(Data([1, 2]).toUInt() == nil) // underflow
        #expect(Data([1, 2, 3]).toUInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4]).toUInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5]).toUInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6]).toUInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6, 7]).toUInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6, 7, 8, 9]).toUInt() == nil) // overflow

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt(from: .littleEndian)
                == 0b0000_1000_0000_0111_0000_0110_0000_0101_0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100_0000_0101_0000_0110_0000_0111_0000_1000
        )

        // both ways
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt()?.toData()
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt(from: .littleEndian)?.toData(.littleEndian)
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt(from: .bigEndian)?.toData(.bigEndian)
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt(from: .littleEndian)?.toData(.bigEndian)
                == Data([8, 7, 6, 5, 4, 3, 2, 1])
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt(from: .bigEndian)?.toData(.littleEndian)
                == Data([8, 7, 6, 5, 4, 3, 2, 1])
        )

        #elseif (arch(arm) || arch(arm64_32) || arch(i386))

        // .toData

        #expect(0b1.uInt.toData(.littleEndian) == Data([0b1, 0, 0, 0]))
        #expect(0b1.uInt.toData(.bigEndian) == Data([0, 0, 0, 0b1]))

        // .toUInt

        #expect(Data([]).toUInt() == nil) // underflow
        #expect(Data([1]).toUInt() == nil) // underflow
        #expect(Data([1, 2]).toUInt() == nil) // underflow
        #expect(Data([1, 2, 3]).toUInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5]).toUInt() == nil) // overflow

        #expect(
            Data([1, 2, 3, 4]).toUInt(from: .littleEndian)
                == 0b0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            Data([1, 2, 3, 4]).toUInt(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100
        )

        // both ways
        #expect(Data([1, 2, 3, 4]).toUInt()?.toData() == Data([1, 2, 3, 4]))

        #expect(
            Data([1, 2, 3, 4]).toUInt(from: .littleEndian)?.toData(.littleEndian)
                == Data([1, 2, 3, 4])
        )
        #expect(
            Data([1, 2, 3, 4]).toUInt(from: .bigEndian)?.toData(.bigEndian)
                == Data([1, 2, 3, 4])
        )

        #expect(
            Data([1, 2, 3, 4]).toUInt(from: .littleEndian)?.toData(.bigEndian)
                == Data([4, 3, 2, 1])
        )
        #expect(
            Data([1, 2, 3, 4]).toUInt(from: .bigEndian)?.toData(.littleEndian)
                == Data([4, 3, 2, 1])
        )

        #else

        XCTFail("Platform not supported yet.")

        #endif
    }

    @Test
    func uInt_uInt8Array() {
        // UInt is 32-bit on 32-bit systems, 64-bit on 64-bit systems
        #if !(arch(arm) || arch(arm64_32) || arch(i386))

        // .toUInt

        #expect(
            ([1, 2, 3, 4, 5, 6, 7, 8] as [UInt8]).toUInt(from: .littleEndian)
                == 0b0000_1000_0000_0111_0000_0110_0000_0101_0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            ([1, 2, 3, 4, 5, 6, 7, 8] as [UInt8]).toUInt(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100_0000_0101_0000_0110_0000_0111_0000_1000
        )

        #elseif (arch(arm) || arch(arm64_32) || arch(i386))

        // .toUInt

        #expect(
            ([1, 2, 3, 4] as [UInt8]).toUInt(from: .littleEndian)
                == 0b0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            ([1, 2, 3, 4] as [UInt8]).toUInt(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100
        )

        #endif
    }

    @Test
    func uInt8() {
        // .toData

        #expect(UInt8(0b1).toData() == Data([0b1]))
        #expect(UInt8(0b1111_1111).toData() == Data([0b1111_1111]))

        // .toUInt8

        #expect(Data([]).toUInt8() == nil) // underflow
        #expect(Data([1]).toUInt8() == 0b0000_0001)
        #expect(Data([1, 2]).toUInt8() == nil) // overflow

        // both ways

        #expect(UInt8(1).toData().toUInt8() == 1)
        #expect(UInt8(255).toData().toUInt8() == 255)
    }

    @Test
    func uInt8_uInt8Array() {
        // .toUInt8

        #expect(([] as [UInt8]).toUInt8() == nil) // underflow
        #expect(([1] as [UInt8]).toUInt8() == 0b0000_0001)
        #expect(([1, 2] as [UInt8]).toUInt8() == nil) // overflow
    }

    @Test
    func uInt16() {
        // .toData

        #expect(UInt16(0b1).toData(.littleEndian) == Data([0b1, 0]))
        #expect(UInt16(0b1).toData(.bigEndian) == Data([0, 0b1]))

        // .toUInt16

        #expect(Data([]).toUInt16() == nil) // underflow
        #expect(Data([1]).toUInt16() == nil) // underflow
        #expect(Data([1, 2, 3]).toUInt16() == nil) // overflow

        #expect(
            Data([1, 2]).toUInt16(from: .littleEndian)
                == 0b0000_0010_0000_0001
        )
        #expect(
            Data([1, 2]).toUInt16(from: .bigEndian)
                == 0b0000_0001_0000_0010
        )

        // both ways
        #expect(Data([1, 2]).toUInt16()?.toData() == Data([1, 2]))

        #expect(Data([1, 2]).toUInt16(from: .littleEndian)?.toData(.littleEndian) == Data([1, 2]))
        #expect(Data([1, 2]).toUInt16(from: .bigEndian)?.toData(.bigEndian) == Data([1, 2]))

        #expect(Data([1, 2]).toUInt16(from: .littleEndian)?.toData(.bigEndian) == Data([2, 1]))
        #expect(Data([1, 2]).toUInt16(from: .bigEndian)?.toData(.littleEndian) == Data([2, 1]))
    }

    @Test
    func uInt16_uInt8Array() {
        // .toUInt16

        #expect(
            ([1, 2] as [UInt8]).toUInt16(from: .littleEndian)
                == 0b0000_0010_0000_0001
        )
        #expect(
            ([1, 2] as [UInt8]).toUInt16(from: .bigEndian)
                == 0b0000_0001_0000_0010
        )
    }

    @Test
    func uInt32() {
        // .toData

        #expect(UInt32(0b1).toData(.littleEndian) == Data([0b1, 0, 0, 0]))
        #expect(UInt32(0b1).toData(.bigEndian) == Data([0, 0, 0, 0b1]))

        // .toUInt32

        #expect(Data([]).toUInt32() == nil) // underflow
        #expect(Data([1]).toUInt32() == nil) // underflow
        #expect(Data([1, 2]).toUInt32() == nil) // underflow
        #expect(Data([1, 2, 3]).toUInt32() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5]).toUInt32() == nil) // overflow

        #expect(
            Data([1, 2, 3, 4]).toUInt32(from: .littleEndian)
                == 0b0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            Data([1, 2, 3, 4]).toUInt32(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100
        )

        // both ways
        #expect(Data([1, 2, 3, 4]).toUInt32()?.toData() == Data([1, 2, 3, 4]))

        #expect(Data([1, 2, 3, 4]).toUInt32(from: .littleEndian)?.toData(.littleEndian) == Data([1, 2, 3, 4]))
        #expect(Data([1, 2, 3, 4]).toUInt32(from: .bigEndian)?.toData(.bigEndian) == Data([1, 2, 3, 4]))

        #expect(Data([1, 2, 3, 4]).toUInt32(from: .littleEndian)?.toData(.bigEndian) == Data([4, 3, 2, 1]))
        #expect(Data([1, 2, 3, 4]).toUInt32(from: .bigEndian)?.toData(.littleEndian) == Data([4, 3, 2, 1]))
    }

    @Test
    func uInt32_uInt8Array() {
        // .toUInt32

        #expect(
            ([1, 2, 3, 4] as [UInt8]).toUInt32(from: .littleEndian)
                == 0b0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            ([1, 2, 3, 4] as [UInt8]).toUInt32(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100
        )
    }

    #if !(arch(arm) || arch(arm64_32) || arch(i386))
    @Test
    func uInt64() {
        // .toData

        #expect(UInt64(0b1).toData(.littleEndian) == Data([0b1, 0, 0, 0, 0, 0, 0, 0]))
        #expect(UInt64(0b1).toData(.bigEndian) == Data([0, 0, 0, 0, 0, 0, 0, 0b1]))

        // .toUInt64

        #expect(Data([]).toUInt64() == nil) // underflow
        #expect(Data([1]).toUInt64() == nil) // underflow
        #expect(Data([1, 2]).toUInt64() == nil) // underflow
        #expect(Data([1, 2, 3]).toUInt64() == nil) // underflow
        #expect(Data([1, 2, 3, 4]).toUInt64() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5]).toUInt64() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6]).toUInt64() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6, 7]).toUInt64() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6, 7, 8, 9]).toUInt64() == nil) // overflow

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt64(from: .littleEndian)
                == 0b0000_1000_0000_0111_0000_0110_0000_0101_0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt64(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100_0000_0101_0000_0110_0000_0111_0000_1000
        )

        // both ways
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt64()?.toData()
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt64(from: .littleEndian)?.toData(.littleEndian)
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt64(from: .bigEndian)?.toData(.bigEndian)
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt64(from: .littleEndian)?.toData(.bigEndian)
                == Data([8, 7, 6, 5, 4, 3, 2, 1])
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toUInt64(from: .bigEndian)?.toData(.littleEndian)
                == Data([8, 7, 6, 5, 4, 3, 2, 1])
        )
    }

    @Test
    func uInt64_uInt8Array() {
        // .toUInt64

        #expect(
            ([1, 2, 3, 4, 5, 6, 7, 8] as [UInt8]).toUInt64(from: .littleEndian)
                == 0b0000_1000_0000_0111_0000_0110_0000_0101_0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            ([1, 2, 3, 4, 5, 6, 7, 8] as [UInt8]).toUInt64(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100_0000_0101_0000_0110_0000_0111_0000_1000
        )
    }
    #endif
}

#endif
