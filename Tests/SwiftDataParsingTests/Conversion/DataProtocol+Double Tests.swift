//
//  DataProtocol+Double Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation) && canImport(CoreFoundation)

import Foundation
import SwiftDataParsing
import Testing

@Suite struct DataProtocol_Double_Tests {
    @Test
    func double() {
        // .toData

        #expect(
            Double(0b1).toData(.littleEndian)
                == Data([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0x3F])
        )
        #expect(
            Double(0b1).toData(.bigEndian)
                == Data([0x3F, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
        )

        // .toDouble

        #expect(Data([]).toDouble() == nil) // underflow
        #expect(Data([1]).toDouble() == nil) // underflow
        #expect(Data([1, 2]).toDouble() == nil) // underflow
        #expect(Data([1, 2, 3]).toDouble() == nil) // underflow
        #expect(Data([1, 2, 3, 4]).toDouble() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5]).toDouble() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6]).toDouble() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6, 7]).toDouble() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5, 6, 7, 8, 9]).toDouble() == nil) // overflow

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toDouble(from: .littleEndian)
                == 5.447603722011605e-270
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toDouble(from: .bigEndian)
                == 8.20788039913184e-304
        )

        // both ways
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toDouble()?.toData()
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toDouble(from: .littleEndian)?.toData(.littleEndian)
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toDouble(from: .bigEndian)?.toData(.bigEndian)
                == Data([1, 2, 3, 4, 5, 6, 7, 8])
        )

        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toDouble(from: .littleEndian)?.toData(.bigEndian)
                == Data([8, 7, 6, 5, 4, 3, 2, 1])
        )
        #expect(
            Data([1, 2, 3, 4, 5, 6, 7, 8]).toDouble(from: .bigEndian)?.toData(.littleEndian)
                == Data([8, 7, 6, 5, 4, 3, 2, 1])
        )
    }

    @Test
    func double_uInt8Array() {
        // .toDouble

        #expect(
            ([1, 2, 3, 4, 5, 6, 7, 8] as [UInt8]).toDouble(from: .littleEndian)
                == 5.447603722011605e-270
        )
        #expect(
            ([1, 2, 3, 4, 5, 6, 7, 8] as [UInt8]).toDouble(from: .bigEndian)
                == 8.20788039913184e-304
        )
    }

    @Test
    func double_data_pointer() {
        // .toDouble

        let data = Data([1, 2, 3, 4, 5, 6, 7, 8])
        data.withContiguousStorageIfAvailable { buffer in // UnsafeBufferPointer<UInt8>
            #expect(
                buffer.toDouble(from: .littleEndian) == 5.447603722011605e-270
            )
            #expect(
                buffer.toDouble(from: .bigEndian) == 8.20788039913184e-304
            )
        }
    }

    @Test
    func double_data_subsequence_pointer() {
        // .toDouble

        let baseData = Data([99, 1, 2, 3, 4, 5, 6, 7, 8])
        let data = baseData[1 ... 8]

        data.withContiguousStorageIfAvailable { buffer in // UnsafeBufferPointer<UInt8>
            #expect(
                buffer.toDouble(from: .littleEndian) == 5.447603722011605e-270
            )
            #expect(
                buffer.toDouble(from: .bigEndian) == 8.20788039913184e-304
            )
        }
    }

    @Test
    func double_rawPointer() {
        // .toDouble

        let data = Data([1, 2, 3, 4, 5, 6, 7, 8])
        data.withUnsafeBytes { buffer in // UnsafeRawBufferPointer
            #expect(
                buffer.toDouble(from: .littleEndian) == 5.447603722011605e-270
            )
            #expect(
                buffer.toDouble(from: .bigEndian) == 8.20788039913184e-304
            )
        }
    }

    @Test
    func double_rawPointer_slice() {
        // .toDouble

        let data = Data([99, 1, 2, 3, 4, 5, 6, 7, 8])
        data.withUnsafeBytes { buffer in // UnsafeRawBufferPointer
            let subdata: Slice<UnsafeRawBufferPointer> = buffer[1 ... 8]
            #expect(
                subdata.toDouble(from: .littleEndian) == 5.447603722011605e-270
            )
            #expect(
                subdata.toDouble(from: .bigEndian) == 8.20788039913184e-304
            )
        }
    }

    @Test
    func double_uInt8Pointer_slice() {
        // .toDouble

        let data = Data([99, 1, 2, 3, 4, 5, 6, 7, 8])
        data.withContiguousStorageIfAvailable { buffer in // UnsafeBufferPointer<UInt8>
            let subdata: Slice<UnsafeBufferPointer<UInt8>> = buffer[1 ... 8]
            #expect(
                subdata.toDouble(from: .littleEndian) == 5.447603722011605e-270
            )
            #expect(
                subdata.toDouble(from: .bigEndian) == 8.20788039913184e-304
            )
        }
    }
}

#endif
