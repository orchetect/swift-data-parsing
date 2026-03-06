//
//  DataProtocol+Int Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation
import SwiftDataParsing
import Testing

@Suite struct DataProtocol_Int_Tests {
    @Test
    func int() async {
        // Int is 32-bit on 32-bit systems, 64-bit on 64-bit systems

        #if !(arch(arm) || arch(arm64_32) || arch(i386))

        // .toData

        #expect(Int(0b1).toData(.littleEndian) == Data([0b1, 0, 0, 0, 0, 0, 0, 0]))
        #expect(Int(0b1).toData(.bigEndian) == Data([0, 0, 0, 0, 0, 0, 0, 0b1]))

        // .toInt64

        #expect(Data([]).toInt() == nil) // underflow
        #expect(Data([1]).toInt() == nil) // underflow
        #expect(Data([1, 2]).toInt() == nil) // underflow
        #expect(Data([1, 2, 3]).toInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4]).toInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5]).toInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6]).toInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6, 7]).toInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6, 7, 8, 9]).toInt() == nil) // overflow

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt(from: .littleEndian)
                == 0b0000_1000_0000_0111_0000_0110_0000_0101_0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100_0000_0101_0000_0110_0000_0111_0000_1000
        )

        // both ways
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt()?.toData()
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt(from: .littleEndian)?.toData(.littleEndian)
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt(from: .bigEndian)?.toData(.bigEndian)
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt(from: .littleEndian)?.toData(.bigEndian)
                == Data([8, 7, 6, 5, 4, 3, 2, 1])
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt(from: .bigEndian)?.toData(.littleEndian)
                == Data([8, 7, 6, 5, 4, 3, 2, 1])
        )

        #elseif (arch(arm) || arch(arm64_32) || !arch(i386))

        // .toData

        #expect(Int(0b1).toData(.littleEndian) == Data([0b1, 0, 0, 0]))
        #expect(Int(0b1).toData(.bigEndian) == Data([0, 0, 0, 0b1]))

        // .toInt64

        #expect(Data([]).toInt() == nil) // underflow
        #expect(Data([1]).toInt() == nil) // underflow
        #expect(Data([1, 2]).toInt() == nil) // underflow
        #expect(Data([1, 2, 3]).toInt() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5]).toInt() == nil) // overflow

        #expect(
            Data([1, 2, 3, 4]).toInt(from: .littleEndian)
                == 0b0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            Data([1, 2, 3, 4]).toInt(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100
        )

        // both ways
        #expect(Data([1, 2, 3, 4]).toInt()?.toData() == Data([1, 2, 3, 4]))

        #expect(
            Data([1, 2, 3, 4]).toInt(from: .littleEndian)?.toData(.littleEndian)
                == Data([1, 2, 3, 4])
        )
        #expect(
            Data([1, 2, 3, 4]).toInt(from: .bigEndian)?.toData(.bigEndian)
                == Data([1, 2, 3, 4])
        )

        #expect(
            Data([1, 2, 3, 4]).toInt(from: .littleEndian)?.toData(.bigEndian)
                == Data([4, 3, 2, 1])
        )
        #expect(
            Data([1, 2, 3, 4]).toInt(from: .bigEndian)?.toData(.littleEndian)
                == Data([4, 3, 2, 1])
        )

        #else

        #fail("Platform not supported yet.")

        #endif
    }

    @Test
    func int_uInt8Array() async {
        // Int is 32-bit on 32-bit systems, 64-bit on 64-bit systems

        #if !(arch(arm) || arch(arm64_32) || arch(i386))

        // .toInt64

        #expect(
            ([1, 2, 3, 4, 5, 6, 7, 8] as [UInt8]).toInt(from: .littleEndian)
                == 0b0000_1000_0000_0111_0000_0110_0000_0101_0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            ([1, 2, 3, 4, 5, 6, 7, 8] as [UInt8]).toInt(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100_0000_0101_0000_0110_0000_0111_0000_1000
        )

        #elseif (arch(arm) || arch(arm64_32) || !arch(i386))

        // .toInt64

        #expect(
            ([1, 2, 3, 4] as [UInt8]).toInt(from: .littleEndian)
                == 0b0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            ([1, 2, 3, 4] as [UInt8]).toInt(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100
        )

        #else

        #fail("Platform not supported yet.")

        #endif
    }

    @Test
    func int8() async {
        // .toData

        #expect(Int8(0b1).toData() == Data([0b1]))
        #expect(Int8(-128).toData() == Data([0b1000_0000]))

        // .toInt8

        #expect(Data([]).toInt8() == nil) // underflow
        #expect(Data([1]).toInt8() == 0b0000_0001)
        #expect(Data([1, 2]).toInt8() == nil) // overflow

        // both ways

        #expect(Int8(1).toData().toInt8() == 1)
        #expect(Int8(127).toData().toInt8() == 127)
        #expect(Int8(-128).toData().toInt8() == -128)
    }

    @Test
    func int8_uInt8Array() async {
        // .toInt8

        #expect(([] as [UInt8]).toInt8() == nil) // underflow
        #expect(([1] as [UInt8]).toInt8() == 0b0000_0001)
        #expect(([1, 2] as [UInt8]).toInt8() == nil) // overflow
    }

    @Test
    func int16() async {
        // .toData

        #expect(Int16(0b1).toData(.littleEndian) == Data([0b1, 0]))
        #expect(Int16(0b1).toData(.bigEndian) == Data([0, 0b1]))

        // .toInt16

        #expect(Data([]).toInt16() == nil) // underflow
        #expect(Data([1]).toInt16() == nil) // underflow
        #expect(Data([1, 2, 3]).toInt16() == nil) // overflow

        #expect(
            Data([1, 2]).toInt16(from: .littleEndian)
                == 0b0000_0010_0000_0001
        )
        #expect(
            Data([1, 2]).toInt16(from: .bigEndian)
                == 0b0000_0001_0000_0010
        )

        // both ways
        #expect(Data([1, 2]).toInt16()?.toData() == Data([1, 2]))

        #expect(
            Data([1, 2]).toInt16(from: .littleEndian)?.toData(.littleEndian)
                == Data([1, 2])
        )
        #expect(Data([1, 2]).toInt16(from: .bigEndian)?.toData(.bigEndian) == Data([1, 2]))

        #expect(Data([1, 2]).toInt16(from: .littleEndian)?.toData(.bigEndian) == Data([2, 1]))
        #expect(Data([1, 2]).toInt16(from: .bigEndian)?.toData(.littleEndian) == Data([2, 1]))
    }

    @Test
    func int16_uInt8Array() async {
        // .toInt16

        #expect(
            ([1, 2] as [UInt8]).toInt16(from: .littleEndian)
                == 0b0000_0010_0000_0001
        )
        #expect(
            ([1, 2] as [UInt8]).toInt16(from: .bigEndian)
                == 0b0000_0001_0000_0010
        )
    }

    @Test
    func int32() async {
        // .toData

        #expect(Int32(0b1).toData(.littleEndian) == Data([0b1, 0, 0, 0]))
        #expect(Int32(0b1).toData(.bigEndian) == Data([0, 0, 0, 0b1]))

        // .toInt32

        #expect(Data([]).toInt32() == nil) // underflow
        #expect(Data([1]).toInt32() == nil) // underflow
        #expect(Data([1, 2]).toInt32() == nil) // underflow
        #expect(Data([1, 2, 3]).toInt32() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5]).toInt32() == nil) // overflow

        #expect(
            Data([1, 2, 3, 4]).toInt32(from: .littleEndian)
                == 0b0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            Data([1, 2, 3, 4]).toInt32(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100
        )

        // both ways
        #expect(Data([1, 2, 3, 4]).toInt32()?.toData() == Data([1, 2, 3, 4]))

        #expect(
            Data([1, 2, 3, 4]).toInt32(from: .littleEndian)?.toData(.littleEndian)
                == Data([1, 2, 3, 4])
        )
        #expect(
            Data([1, 2, 3, 4]).toInt32(from: .bigEndian)?.toData(.bigEndian)
                == Data([1, 2, 3, 4])
        )

        #expect(
            Data([1, 2, 3, 4]).toInt32(from: .littleEndian)?.toData(.bigEndian)
                == Data([4, 3, 2, 1])
        )
        #expect(
            Data([1, 2, 3, 4]).toInt32(from: .bigEndian)?.toData(.littleEndian)
                == Data([4, 3, 2, 1])
        )
    }

    @Test
    func int32_uInt8Array() async {
        // .toInt32

        #expect(
            ([1, 2, 3, 4] as [UInt8]).toInt32(from: .littleEndian)
                == 0b0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            ([1, 2, 3, 4] as [UInt8]).toInt32(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100
        )
    }

    @Test
    func int32_data_pointer() async {
        // .toInt32

        let data = Data([1, 2, 3, 4])
        data.withContiguousStorageIfAvailable { buffer in // UnsafeBufferPointer<UInt8>
            #expect(
                buffer.toInt32(from: .littleEndian)
                    == 0b0000_0100_0000_0011_0000_0010_0000_0001
            )
            #expect(
                buffer.toInt32(from: .bigEndian)
                    == 0b0000_0001_0000_0010_0000_0011_0000_0100
            )
        }
    }

    @Test
    func int32_data_subsequence_pointer() async {
        // .toInt32

        let baseData = Data([99, 1, 2, 3, 4])
        let data = baseData[1 ... 4]

        data.withContiguousStorageIfAvailable { buffer in // UnsafeBufferPointer<UInt8>
            #expect(
                buffer.toInt32(from: .littleEndian)
                    == 0b0000_0100_0000_0011_0000_0010_0000_0001
            )
            #expect(
                buffer.toInt32(from: .bigEndian)
                    == 0b0000_0001_0000_0010_0000_0011_0000_0100
            )
        }
    }

    @Test
    func int32_rawPointer() async {
        // .toInt32

        let data = Data([1, 2, 3, 4])
        data.withUnsafeBytes { buffer in // UnsafeRawBufferPointer
            #expect(
                buffer.toInt32(from: .littleEndian)
                    == 0b0000_0100_0000_0011_0000_0010_0000_0001
            )
            #expect(
                buffer.toInt32(from: .bigEndian)
                    == 0b0000_0001_0000_0010_0000_0011_0000_0100
            )
        }
    }

    @Test
    func int32_rawPointer_slice() async {
        // .toInt32

        let data = Data([99, 1, 2, 3, 4])
        data.withUnsafeBytes { buffer in // UnsafeRawBufferPointer
            let subdata: Slice<UnsafeRawBufferPointer> = buffer[1 ... 4]
            #expect(
                subdata.toInt32(from: .littleEndian)
                    == 0b0000_0100_0000_0011_0000_0010_0000_0001
            )
            #expect(
                subdata.toInt32(from: .bigEndian)
                    == 0b0000_0001_0000_0010_0000_0011_0000_0100
            )
        }
    }

    @Test
    func int32_uInt8Pointer_slice() async {
        // .toInt32

        let data = Data([99, 1, 2, 3, 4])
        data.withContiguousStorageIfAvailable { buffer in // UnsafeBufferPointer<UInt8>
            let subdata: Slice<UnsafeBufferPointer<UInt8>> = buffer[1 ... 4]
            #expect(
                subdata.toInt32(from: .littleEndian)
                    == 0b0000_0100_0000_0011_0000_0010_0000_0001
            )
            #expect(
                subdata.toInt32(from: .bigEndian)
                    == 0b0000_0001_0000_0010_0000_0011_0000_0100
            )
        }
    }

    #if !(arch(arm) || arch(arm64_32) || arch(i386))
    @Test
    func int64() async {
        // .toData

        #expect(Int64(0b1).toData(.littleEndian) == Data([0b1, 0, 0, 0, 0, 0, 0, 0]))
        #expect(Int64(0b1).toData(.bigEndian) == Data([0, 0, 0, 0, 0, 0, 0, 0b1]))

        // .toInt64

        #expect(Data([]).toInt64() == nil) // underflow
        #expect(Data([1]).toInt64() == nil) // underflow
        #expect(Data([1, 2]).toInt64() == nil) // underflow
        #expect(Data([1, 2, 3]).toInt64() == nil) // underflow
        #expect(Data([1, 2, 3, 4]).toInt64() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5]).toInt64() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6]).toInt64() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6, 7]).toInt64() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6, 7, 8, 9]).toInt64() == nil) // overflow

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt64(from: .littleEndian)
                == 0b0000_1000_0000_0111_0000_0110_0000_0101_0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt64(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100_0000_0101_0000_0110_0000_0111_0000_1000
        )

        // both ways
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt64()?.toData()
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt64(from: .littleEndian)?.toData(.littleEndian)
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt64(from: .bigEndian)?.toData(.bigEndian)
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt64(from: .littleEndian)?.toData(.bigEndian)
                == Data([8, 7, 6, 5, 4, 3, 2, 1])
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toInt64(from: .bigEndian)?.toData(.littleEndian)
                == Data([8, 7, 6, 5, 4, 3, 2, 1])
        )
    }

    @Test
    func int64_uInt8Array() async {
        // .toInt64

        #expect(
            ([1, 2, 3, 4, 5, 6, 7, 8] as [UInt8]).toInt64(from: .littleEndian)
                == 0b0000_1000_0000_0111_0000_0110_0000_0101_0000_0100_0000_0011_0000_0010_0000_0001
        )
        #expect(
            ([1, 2, 3, 4, 5, 6, 7, 8] as [UInt8]).toInt64(from: .bigEndian)
                == 0b0000_0001_0000_0010_0000_0011_0000_0100_0000_0101_0000_0110_0000_0111_0000_1000
        )
    }
    #endif
}

#endif
