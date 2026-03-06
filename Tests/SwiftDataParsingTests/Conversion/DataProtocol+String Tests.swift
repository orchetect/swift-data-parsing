//
//  DataProtocol+String Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation
import SwiftDataParsing
import Testing

@Suite struct DataProtocol_String_Tests {
    @Test
    func string() throws {
        let sourceString = "This is a test string"
        
        let expectedBytes: [UInt8] = [
            0x54, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73, 0x20,
            0x61, 0x20, 0x74, 0x65, 0x73, 0x74, 0x20, 0x73,
            0x74, 0x72, 0x69, 0x6E, 0x67
        ]
        
        // String -> Data
        
        #expect(try #require(sourceString.toData(using: .utf8)) == Data(expectedBytes))
        
        // Data -> String
        
        let convertedString = Data(expectedBytes).toString(using: .utf8)
        
        #expect(convertedString == sourceString)
    }
    
    @Test
    func string_uInt8Array() throws {
        let sourceString = "This is a test string"
        
        let expectedBytes: [UInt8] = [
            0x54, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73, 0x20,
            0x61, 0x20, 0x74, 0x65, 0x73, 0x74, 0x20, 0x73,
            0x74, 0x72, 0x69, 0x6E, 0x67
        ]
        
        // Data -> String
        
        let convertedString = expectedBytes.toString(using: .utf8)
        
        #expect(convertedString == sourceString)
    }
}

#endif
