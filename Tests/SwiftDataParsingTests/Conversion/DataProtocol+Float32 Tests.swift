//
//  DataProtocol+Float32 Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation) && canImport(CoreFoundation)

import Foundation
import SwiftDataParsing
import Testing

@Suite struct DataProtocol_Float32_Tests {
    @Test
    func float32() {
        // .toData

        #expect(Float32(0b1).toData(.littleEndian) == Data([0x00, 0x00, 0x80, 0x3F]))
        #expect(Float32(0b1).toData(.bigEndian) == Data([0x3F, 0x80, 0x00, 0x00]))

        // .toFloat32

        #expect(Data([]).toFloat32() == nil) // underflow
        #expect(Data([1]).toFloat32() == nil) // underflow
        #expect(Data([1, 2]).toFloat32() == nil) // underflow
        #expect(Data([1, 2, 3]).toFloat32() == nil) // underflow
        #expect(Data([1, 2, 3, 4, 5]).toFloat32() == nil) // overflow

        #expect(Data([1, 2, 3, 4]).toFloat32(from: .littleEndian) == 1.5399896e-36)
        #expect(Data([1, 2, 3, 4]).toFloat32(from: .bigEndian) == 2.3879393e-38)

        // both ways
        #expect(Data([1, 2, 3, 4]).toFloat32()?.toData() == Data([1, 2, 3, 4]))

        #expect(
            Data([1, 2, 3, 4]).toFloat32(from: .littleEndian)?.toData(.littleEndian)
                == Data([1, 2, 3, 4])
        )
        #expect(
            Data([1, 2, 3, 4]).toFloat32(from: .bigEndian)?.toData(.bigEndian)
                == Data([1, 2, 3, 4])
        )

        #expect(
            Data([1, 2, 3, 4]).toFloat32(from: .littleEndian)?.toData(.bigEndian)
                == Data([4, 3, 2, 1])
        )
        #expect(
            Data([1, 2, 3, 4]).toFloat32(from: .bigEndian)?.toData(.littleEndian)
                == Data([4, 3, 2, 1])
        )
    }

    @Test
    func float32_uInt8Array() {
        // .toFloat32

        #expect(([1, 2, 3, 4] as [UInt8]).toFloat32(from: .littleEndian) == 1.5399896e-36)
        #expect(([1, 2, 3, 4] as [UInt8]).toFloat32(from: .bigEndian) == 2.3879393e-38)
    }

    @Test
    func float32_data_pointer() {
        // .toFloat32

        let data = Data([1, 2, 3, 4])
        data.withContiguousStorageIfAvailable { buffer in // UnsafeBufferPointer<UInt8>
            #expect(
                buffer.toFloat32(from: .littleEndian) == 1.5399896e-36
            )
            #expect(
                buffer.toFloat32(from: .bigEndian) == 2.3879393e-38
            )
        }
    }

    @Test
    func float32_data_subsequence_pointer() {
        // .toFloat32

        let baseData = Data([99, 1, 2, 3, 4])
        let data = baseData[1 ... 4]

        data.withContiguousStorageIfAvailable { buffer in // UnsafeBufferPointer<UInt8>
            #expect(
                buffer.toFloat32(from: .littleEndian) == 1.5399896e-36
            )
            #expect(
                buffer.toFloat32(from: .bigEndian) == 2.3879393e-38
            )
        }
    }

    @Test
    func float32_rawPointer() {
        // .toFloat32

        let data = Data([1, 2, 3, 4])
        data.withUnsafeBytes { buffer in // UnsafeRawBufferPointer
            #expect(
                buffer.toFloat32(from: .littleEndian) == 1.5399896e-36
            )
            #expect(
                buffer.toFloat32(from: .bigEndian) == 2.3879393e-38
            )
        }
    }

    @Test
    func float32_rawPointer_slice() {
        // .toFloat32

        let data = Data([99, 1, 2, 3, 4])
        data.withUnsafeBytes { buffer in // UnsafeRawBufferPointer
            let subdata: Slice<UnsafeRawBufferPointer> = buffer[1 ... 4]
            #expect(
                subdata.toFloat32(from: .littleEndian) == 1.5399896e-36
            )
            #expect(
                subdata.toFloat32(from: .bigEndian) == 2.3879393e-38
            )
        }
    }

    @Test
    func float32_uInt8Pointer_slice() {
        // .toFloat32

        let data = Data([99, 1, 2, 3, 4])
        data.withContiguousStorageIfAvailable { buffer in // UnsafeBufferPointer<UInt8>
            let subdata: Slice<UnsafeBufferPointer<UInt8>> = buffer[1 ... 4]
            #expect(
                subdata.toFloat32(from: .littleEndian) == 1.5399896e-36
            )
            #expect(
                subdata.toFloat32(from: .bigEndian) == 2.3879393e-38
            )
        }
    }
}

#endif
