//
//  InoutDataParser Data Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation
import SwiftDataParsing
import Testing

/// Identical to `[Int8]` tests, except using `Data` as base data type instead.
@Suite struct InoutDataParser_Data_Tests {
    // MARK: - Data storage starting with index 0
    
    @Test
    func read() async throws {
        var data = Data([0x01, 0x02, 0x03, 0x04])
        
        // .read(bytes:)
        try data.withInoutDataParser { parser in
            #expect(parser.readOffset == 0)
            #expect(parser.remainingByteCount == 4)
            try #expect(parser.read(bytes: 1) == [0x01])
            #expect(parser.remainingByteCount == 3)
            try #expect(parser.read(bytes: 1) == [0x02])
            #expect(parser.remainingByteCount == 2)
            try #expect(parser.read(bytes: 1) == [0x03])
            #expect(parser.remainingByteCount == 1)
            try #expect(parser.read(bytes: 1) == [0x04])
            #expect(parser.remainingByteCount == 0)
            #expect(throws: (any Error).self) { try parser.read(bytes: 1) }
            #expect(parser.remainingByteCount == 0)
        }
        
        // .readByte()
        try data.withInoutDataParser { parser in
            #expect(parser.readOffset == 0)
            #expect(parser.remainingByteCount == 4)
            try #expect(parser.readByte() == 0x01)
            #expect(parser.remainingByteCount == 3)
            try #expect(parser.readByte() == 0x02)
            #expect(parser.remainingByteCount == 2)
            try #expect(parser.readByte() == 0x03)
            #expect(parser.remainingByteCount == 1)
            try #expect(parser.readByte() == 0x04)
            #expect(parser.remainingByteCount == 0)
            #expect(throws: (any Error).self) { try parser.readByte() }
            #expect(parser.remainingByteCount == 0)
        }
        
        // .read - nil read - return all remaining bytes
        try data.withInoutDataParser { parser in
            try #expect(parser.read() == [0x01, 0x02, 0x03, 0x04])
            #expect(throws: (any Error).self) { try parser.read(bytes: 1) }
        }
        
        // .read - zero count read - return empty data, not nil
        try data.withInoutDataParser { parser in
            try #expect(parser.read(bytes: 0) == [])
        }
        
        // .read - read overflow - return nil
        data.withInoutDataParser { parser in
            #expect(throws: (any Error).self) { try parser.read(bytes: 5) }
        }
    }
    
    @Test
    func nonAdvancingRead() async throws {
        var data = Data([0x01, 0x02, 0x03, 0x04])
        
        // .nonAdvancingRead - nil read - return all remaining bytes
        try data.withInoutDataParser { parser in
            try #expect(parser.read(advance: false) == [0x01, 0x02, 0x03, 0x04])
            try #expect(parser.read(bytes: 1) == [0x01])
        }
        
        // single bytes
        try data.withInoutDataParser { parser in
            try #expect(parser.readByte(advance: false) == 0x01)
            try #expect(parser.readByte(advance: false) == 0x01)
            try #expect(parser.readByte() == 0x01)
            try #expect(parser.readByte() == 0x02)
        }
        
        // .nonAdvancingRead - read byte counts
        try data.withInoutDataParser { parser in
            try #expect(parser.read(bytes: 1, advance: false) == [0x01])
            try #expect(parser.read(bytes: 2, advance: false) == [0x01, 0x02])
        }
        
        // .nonAdvancingRead - read overflow - return nil
        try data.withInoutDataParser { parser in
            #expect(throws: (any Error).self) { try parser.read(bytes: 5, advance: false) }
            try #expect(parser.read(bytes: 1) == [0x01])
        }
    }
    
    @Test
    func seekBy() async throws {
        var data = Data([0x01, 0x02, 0x03, 0x04])
        
        // seekBy
        try data.withInoutDataParser { parser in
            try parser.seek(by: 1)
            try #expect(parser.read(bytes: 1, advance: false) == [0x02])
            try parser.seek(by: 2)
            try #expect(parser.read(bytes: 1) == [0x04])
            #expect(parser.readOffset == 4) // past end
            try parser.seek(by: 0)
            #expect(parser.readOffset == 4)
            try parser.seek(by: -1)
            #expect(parser.readOffset == 3)
            try parser.seek(by: -3)
            #expect(parser.readOffset == 0)
            #expect(throws: DataParserError.pastStartOfStream) { try parser.seek(by: -1) }
            try parser.seek(by: 4)
            #expect(throws: DataParserError.pastEndOfStream) { try parser.seek(by: 1) }
        }
    }
    
    @Test
    func reset() async throws {
        var data = Data([0x01, 0x02, 0x03, 0x04])
        
        // reset
        try data.withInoutDataParser { parser in
            try #expect(parser.read(bytes: 1) == [0x01])
            try #expect(parser.read(bytes: 2) == [0x02, 0x03])
            parser.reset()
            try #expect(parser.read(bytes: 1) == [0x01])
        }
    }
    
    // MARK: - Data storage starting with index >0
    
    @Test
    func read_DataIndicesOffset() async throws {
        let rawData = Data([0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04])
        var data = rawData[3 ... 6]
        
        // .read - byte by byte
        try data.withInoutDataParser { parser in
            #expect(parser.readOffset == 0)
            try #expect(parser.read(bytes: 1) == [0x01])
            try #expect(parser.read(bytes: 1) == [0x02])
            try #expect(parser.read(bytes: 1) == [0x03])
            try #expect(parser.read(bytes: 1) == [0x04])
            #expect(throws: (any Error).self) { try parser.read(bytes: 1) }
        }
        
        // .read - nil read - return all remaining bytes
        try data.withInoutDataParser { parser in
            try #expect(parser.read() == [0x01, 0x02, 0x03, 0x04])
            #expect(throws: (any Error).self) { try parser.read(bytes: 1) }
        }
        
        // .read - zero count read - return empty data, not nil
        try data.withInoutDataParser { parser in
            try #expect(parser.read(bytes: 0) == [])
        }
        
        // .read - read overflow - return nil
        data.withInoutDataParser { parser in
            #expect(throws: (any Error).self) { try parser.read(bytes: 5) }
        }
    }
    
    @Test
    func nonAdvancingRead_DataIndicesOffset() async throws {
        let rawData = Data([0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04])
        var data = rawData[3 ... 6]
        
        // .nonAdvancingRead - nil read - return all remaining bytes
        try data.withInoutDataParser { parser in
            try #expect(parser.read(advance: false) == [0x01, 0x02, 0x03, 0x04])
            try #expect(parser.read(bytes: 1) == [0x01])
        }
        
        // .nonAdvancingRead - read byte counts
        try data.withInoutDataParser { parser in
            try #expect(parser.read(bytes: 1, advance: false) == [0x01])
            try #expect(parser.read(bytes: 2, advance: false) == [0x01, 0x02])
        }
        
        // .nonAdvancingRead - read overflow - return nil
        try data.withInoutDataParser { parser in
            #expect(throws: (any Error).self) { try parser.read(bytes: 5, advance: false) }
            try #expect(parser.read(bytes: 1) == [0x01])
        }
        
        // .nonAdvancingRead - read overflow - return nil
        data.withInoutDataParser { parser in
            #expect(throws: (any Error).self) { try parser.read(bytes: 8) }
        }
    }
    
    @Test
    func advanceBy_DataIndicesOffset() async throws {
        let rawData = Data([0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04])
        var data = rawData[3 ... 6]
        
        // advanceBy
        try data.withInoutDataParser { parser in
            try parser.seek(by: 1)
            try #expect(parser.read(bytes: 1) == [0x02])
        }
    }
    
    @Test
    func reset_DataIndicesOffset() async throws {
        let rawData = Data([0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04])
        var data = rawData[3 ... 6]
        
        // reset
        try data.withInoutDataParser { parser in
            try #expect(parser.read(bytes: 1) == [0x01])
            try #expect(parser.read(bytes: 2) == [0x02, 0x03])
            parser.reset()
            try #expect(parser.read(bytes: 1) == [0x01])
        }
    }
    
    @Test
    func withInoutDataParser() async throws {
        var data = Data([0x01, 0x02, 0x03, 0x04])
        
        try data.withInoutDataParser { parser in
            #expect(parser.readOffset == 0)
            try #expect(parser.read(bytes: 1) == [0x01])
            try #expect(parser.read(bytes: 1) == [0x02])
            try #expect(parser.read(bytes: 1) == [0x03])
            try #expect(parser.read(bytes: 1) == [0x04])
            #expect(throws: (any Error).self) { try parser.read(bytes: 1) }
        }
        
        struct TestError: Error { }
        
        #expect(throws: (any Error).self) {
            try data.withInoutDataParser { parser in
                throw TestError()
            }
        }
    }
    
    @Test
    func withInoutDataParser_ReturnsValue() async throws {
        var data = Data([0x01, 0x02, 0x03, 0x04])

        #if swift(>=5.7)
        let getByte = try data.withInoutDataParser { parser in
            _ = try parser.readByte()
            return try parser.readByte()
        }
        #else
        let getByte: UInt8 = try data.withInoutDataParser { parser in
            _ = try parser.readByte()
            return try parser.readByte()
        }
        #endif

        #expect(getByte == 0x02)
    }
}

#endif
