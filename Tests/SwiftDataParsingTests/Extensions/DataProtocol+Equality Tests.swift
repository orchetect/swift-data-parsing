//
//  DataProtocol+Equality Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation
import SwiftDataParsing
import Testing

@Suite struct DataProtocol_Equality_Tests {
    // MARK: - lhs: [UInt8]
    
    /// DataProtocol == Data
    @Test
    func uInt8Array_equalTo_data() async throws {
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        #expect(array == Data([0x01, 0x02, 0x03, 0x04]))
    }
    
    /// DataProtocol == Data
    @Test
    func uInt8Array_equalTo_subData() async throws {
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04])
        let subdata = data[1...]
        #expect(array == subdata)
    }
    
    /// [UInt8] == [UInt8]
    /// (built-in, not testing package code)
    @Test
    func uInt8Array_equalTo_uInt8Array() async throws {
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        #expect(array == ([0x01, 0x02, 0x03, 0x04] as [UInt8]))
    }
    
    /// DataProtocol == ArraySlice<UInt8>
    @Test
    func uInt8Array_equalTo_uInt8ArraySlice() async throws {
        let array1: [UInt8] = [0x02, 0x03]
        
        let array2: [UInt8] = [0x00, 0x01, 0x02, 0x03, 0x04]
        let slice2: ArraySlice<UInt8> = array2[2 ... 3]
        
        #expect(array1 == slice2)
    }
    
    /// DataProtocol == UnsafeBufferPointer<UInt8>
    @Test
    func uInt8Array_equalTo_uInt8BufferPointer() async throws {
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        let data = Data([0x01, 0x02, 0x03, 0x04])
        
        data.withContiguousStorageIfAvailable { buffer in
            #expect(array == buffer)
        }
    }
    
    /// DataProtocol == Slice<UnsafeBufferPointer<UInt8>>
    @Test
    func uInt8Array_equalTo_uInt8BufferPointerSlice() async throws {
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        let data = Data([0x00, 0x01, 0x02, 0x03, 0x04])
        
        data.withContiguousStorageIfAvailable { buffer in
            let bufferSlice = buffer[1...]
            #expect(array == bufferSlice)
        }
    }
    
    // MARK: - lhs: ArraySlice<UInt8>
    
    /// DataProtocol == Data
    @Test
    func uInt8ArraySlice_equalTo_data() async throws {
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        let slice: ArraySlice<UInt8> = array[1 ... 2]
        #expect(slice == Data([0x02, 0x03]))
    }
    
    /// DataProtocol == Data
    @Test
    func uInt8ArraySlice_equalTo_subData() async throws {
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        let slice: ArraySlice<UInt8> = array[1 ... 2]
        
        let data = Data([0x01, 0x02, 0x03, 0x04])
        let subdata = data[1 ... 2]
        
        #expect(slice == subdata)
    }
    
    /// DataProtocol == [UInt8]
    @Test
    func uInt8ArraySlice_equalTo_uInt8Array() async throws {
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        let slice: ArraySlice<UInt8> = array[1 ... 2]
        #expect(slice == ([0x02, 0x03] as [UInt8]))
    }
    
    /// ArraySlice<UInt8> == ArraySlice<UInt8>
    /// (built-in, not testing package code)
    @Test
    func uInt8ArraySlice_equalTo_uInt8ArraySlice() async throws {
        let array1: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        let slice1: ArraySlice<UInt8> = array1[1 ... 2]
        
        let array2: [UInt8] = [0x00, 0x01, 0x02, 0x03, 0x04]
        let slice2: ArraySlice<UInt8> = array2[2 ... 3]
        
        #expect(slice1 == slice2)
    }
    
    /// DataProtocol == UnsafeBufferPointer<UInt8>
    @Test
    func uInt8ArraySlice_equalTo_uInt8BufferPointer() async throws {
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        let slice: ArraySlice<UInt8> = array[1 ... 2]
        
        let data = Data([0x02, 0x03])
        data.withContiguousStorageIfAvailable { buffer in
            #expect(slice == buffer)
        }
    }
    
    /// DataProtocol == Slice<UnsafeBufferPointer<UInt8>>
    @Test
    func uInt8ArraySlice_equalTo_uInt8BufferPointerSlice() async throws {
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        let slice: ArraySlice<UInt8> = array[1 ... 2]
        
        let data = Data([0x00, 0x02, 0x03])
        data.withContiguousStorageIfAvailable { buffer in
            let bufferSlice = buffer[1...]
            #expect(slice == bufferSlice)
        }
    }
    
    // MARK: - lhs: Data
    
    /// DataProtocol == DataProtocol
    /// (built-in, not testing package code)
    @Test
    func data_equalTo_data() async throws {
        let data1 = Data([0x01, 0x02, 0x03, 0x04])
        let data2 = Data([0x01, 0x02, 0x03, 0x04])
        #expect(data1 == data2)
    }
    
    /// DataProtocol == DataProtocol
    /// (built-in, not testing package code)
    @Test
    func data_equalTo_subData() async throws {
        let data1 = Data([0x01, 0x02, 0x03, 0x04])
        
        let data2 = Data([0x00, 0x01, 0x02, 0x03, 0x04])
        let subdata2 = data2[1...]
        #expect(data1 == subdata2)
    }
    
    /// DataProtocol == [UInt8]
    @Test
    func data_equalTo_uInt8Array() async throws {
        let data = Data([0x01, 0x02, 0x03, 0x04])
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        #expect(data == array)
    }
    
    /// DataProtocol == ArraySlice<UInt8>
    @Test
    func data_equalTo_uInt8ArraySlice() async throws {
        let data = Data([0x01, 0x02, 0x03, 0x04])
        
        let array: [UInt8] = [0x00, 0x01, 0x02, 0x03, 0x04]
        let slice: ArraySlice<UInt8> = array[1...]
        
        #expect(data == slice)
    }
    
    /// DataProtocol == UnsafeBufferPointer<UInt8>
    @Test
    func data_equalTo_uInt8BufferPointer() async throws {
        let data1 = Data([0x01, 0x02, 0x03, 0x04])
        let data2 = Data([0x01, 0x02, 0x03, 0x04])
        data2.withContiguousStorageIfAvailable { data2Buffer in
            #expect(data1 == data2Buffer)
        }
    }
    
    /// DataProtocol == Slice<UnsafeBufferPointer<UInt8>>
    @Test
    func data_equalTo_uInt8BufferPointerSlice() async throws {
        let data1 = Data([0x01, 0x02, 0x03, 0x04])
        let data2 = Data([0x00, 0x01, 0x02, 0x03, 0x04])
        data2.withContiguousStorageIfAvailable { data2Buffer in
            let data2BufferSlice = data2Buffer[1...]
            #expect(data1 == data2BufferSlice)
        }
    }
    
    // MARK: - lhs: UInt8 Buffer Pointer
    
    /// DataProtocol == Data
    @Test
    func uInt8BufferPointer_equalTo_data() async throws {
        let data = Data([0x01, 0x02, 0x03, 0x04])
        data.withContiguousStorageIfAvailable { buffer in
            #expect(buffer == Data([0x01, 0x02, 0x03, 0x04]))
        }
    }
    
    /// DataProtocol == Data
    @Test
    func uInt8BufferPointer_equalTo_subData() async throws {
        let data = Data([0x01, 0x02, 0x03, 0x04])
        
        let data2 = Data([0x00, 0x01, 0x02, 0x03, 0x04])
        let subdata2 = data2[1...]
        
        data.withContiguousStorageIfAvailable { buffer in
            #expect(buffer == subdata2)
        }
    }
    
    /// DataProtocol == [UInt8]
    @Test
    func uInt8BufferPointer_equalTo_uInt8Array() async throws {
        let data = Data([0x01, 0x02, 0x03, 0x04])
        let array: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        data.withContiguousStorageIfAvailable { buffer in
            #expect(buffer == array)
        }
    }
    
    /// DataProtocol == ArraySlice<UInt8>
    @Test
    func uInt8BufferPointer_equalTo_uInt8ArraySlice() async throws {
        let data = Data([0x01, 0x02, 0x03, 0x04])
        
        let array: [UInt8] = [0x00, 0x01, 0x02, 0x03, 0x04]
        let slice = array[1...]
        
        data.withContiguousStorageIfAvailable { buffer in
            #expect(buffer == slice)
        }
    }
    
    /// DataProtocol == UnsafeBufferPointer<UInt8>
    @Test
    func uInt8BufferPointer_equalTo_uInt8BufferPointer() async throws {
        let data1 = Data([0x01, 0x02, 0x03, 0x04])
        let data2 = Data([0x01, 0x02, 0x03, 0x04])
        
        data1.withContiguousStorageIfAvailable { data1Buffer in
            data2.withContiguousStorageIfAvailable { data2Buffer in
                #expect(data1Buffer == data2Buffer)
            }
        }
    }
    
    /// DataProtocol == Slice<UnsafeBufferPointer<UInt8>>
    @Test
    func uInt8BufferPointer_equalTo_uInt8BufferPointerSlice() async throws {
        let data1 = Data([0x01, 0x02, 0x03, 0x04])
        let data2 = Data([0x00, 0x01, 0x02, 0x03, 0x04])
        
        data1.withContiguousStorageIfAvailable { data1Buffer in
            data2.withContiguousStorageIfAvailable { data2Buffer in
                let data2BufferSlice = data2Buffer[1...]
                #expect(data1Buffer == data2BufferSlice)
            }
        }
    }
}

#endif
