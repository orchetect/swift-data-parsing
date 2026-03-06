//
//  DataProtocol+Collection Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation
import SwiftDataParsing
import Testing

@Suite struct DataProtocol_Collection_Tests {
    @Test
    func dataUInt8Bytes() {
        let sourceBytes: [UInt8] = [1, 2, 3]
        
        // Collection -> Data
        
        #expect(sourceBytes.toData() == Data([1, 2, 3]))
        
        // Data -> Collection
        
        #expect(Data(sourceBytes).toUInt8Bytes() == [1, 2, 3])
    }
    
    @Test
    func dataUInt8Bytes_uInt8Array() {
        let sourceBytes: [UInt8] = [1, 2, 3]
        
        // Collection -> Data
        
        let data: Data = sourceBytes.toData()
        #expect(data == [1, 2, 3])
        
        // Data -> Collection
        
        let bytes: [UInt8] = sourceBytes.toUInt8Bytes()
        #expect(bytes == [1, 2, 3])
    }
}

#endif
