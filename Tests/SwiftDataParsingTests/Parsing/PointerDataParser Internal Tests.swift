//
//  PointerDataParser Internal Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation
@testable import SwiftDataParsing
import Testing

@Suite struct PointerDataParser_Internal_Tests {
    @Test
    func internals() async throws {
        let data = Data([0x01, 0x02, 0x03, 0x04])
        
        try data.withPointerDataParser { parser in
            #expect(parser._dataSize() == 4)
            
            #expect(parser._dataStartIndex() == 0)
            
            #expect(parser._dataReadOffsetIndex(offsetBy: 0) == 0)
            #expect(parser._dataReadOffsetIndex(offsetBy: 1) == 1)
            #expect(parser._dataReadOffsetIndex(offsetBy: 2) == 2)
            
            try #expect(parser._dataByte(at: 0) == 0x01)
            try #expect(parser._dataByte(at: 1) == 0x02)
            try #expect(parser._dataByte(at: 2) == 0x03)
            try #expect(parser._dataByte(at: 3) == 0x04)
            
            try #expect(parser._dataBytes(in: 0 ... 0) == [0x01])
            try #expect(parser._dataBytes(in: 1 ... 1) == [0x02])
            try #expect(parser._dataBytes(in: 2 ... 2) == [0x03])
            try #expect(parser._dataBytes(in: 3 ... 3) == [0x04])
            try #expect(parser._dataBytes(in: 0 ... 1) == [0x01, 0x02])
            try #expect(parser._dataBytes(in: 0 ... 3) == [0x01, 0x02, 0x03, 0x04])
            try #expect(parser._dataBytes(in: 1 ... 3) == [0x02, 0x03, 0x04])
        }
    }
}

#endif
