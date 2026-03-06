//
//  PointerDataParser DataProtocol Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation
import SwiftDataParsing
import Testing

@Suite struct PointerDataParser_DataProtocol_Tests {
    @Test
    func dataProtocolGenerics() async throws {
        var data = Data([0x01, 0x02, 0x03, 0x04])
        
        try await readGenericData(data: &data)
    }
    
    func readGenericData<D: DataProtocol>(data: inout D) async throws {
        try data.withPointerDataParser { parser in
            // basic test
            try #expect(parser.readByte() == 0x01)
            try #expect(parser.readByte() == 0x02)
            try #expect(parser.readByte() == 0x03)
            try #expect(parser.readByte() == 0x04)
        }
    }
}

#endif
