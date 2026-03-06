//
//  PointerDataParser UInt8 Array Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation
import SwiftDataParsing
import Testing

/// Identical to `Data` tests, except using `[Int8]` as base data type instead.
@Suite struct PointerDataParser_UInt8Array_Tests {
    // MARK: - Data storage starting with index 0
    
    @Test
    func read() async throws {
        let data: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        
        // .read(bytes:)
        try data.withPointerDataParser { parser in
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
        try data.withPointerDataParser { parser in
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
        try data.withPointerDataParser { parser in
            try #expect(parser.read() == [0x01, 0x02, 0x03, 0x04])
            #expect(throws: (any Error).self) { try parser.read(bytes: 1) }
        }
        
        // .read - zero count read - return empty data, not nil
        try data.withPointerDataParser { parser in
            try #expect(parser.read(bytes: 0) == [])
        }
        
        // .read - read overflow - return nil
        data.withPointerDataParser { parser in
            #expect(throws: (any Error).self) { try parser.read(bytes: 5) }
        }
    }
    
    @Test
    func nonAdvancingRead() async throws {
        let data: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        
        // .nonAdvancingRead - nil read - return all remaining bytes
        try data.withPointerDataParser { parser in
            try #expect(parser.nonAdvancingRead() == [0x01, 0x02, 0x03, 0x04])
            try #expect(parser.read(bytes: 1) == [0x01])
        }
        
        // single bytes
        try data.withPointerDataParser { parser in
            try #expect(parser.nonAdvancingReadByte() == 0x01)
            try #expect(parser.nonAdvancingReadByte() == 0x01)
            try #expect(parser.readByte() == 0x01)
            try #expect(parser.readByte() == 0x02)
        }
        
        // .nonAdvancingRead - read byte counts
        try data.withPointerDataParser { parser in
            try #expect(parser.nonAdvancingRead(bytes: 1) == [0x01])
            try #expect(parser.nonAdvancingRead(bytes: 2) == [0x01, 0x02])
        }
        
        // .nonAdvancingRead - read overflow - return nil
        try data.withPointerDataParser { parser in
            #expect(throws: (any Error).self) { try parser.nonAdvancingRead(bytes: 5) }
            try #expect(parser.read(bytes: 1) == [0x01])
        }
    }
    
    @Test
    func advanceBy() async throws {
        let data: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        
        // advanceBy
        try data.withPointerDataParser { parser in
            parser.advanceBy(1)
            try #expect(parser.read(bytes: 1) == [0x02])
        }
    }
    
    @Test
    func reset() async throws {
        let data: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        
        // reset
        try data.withPointerDataParser { parser in
            try #expect(parser.read(bytes: 1) == [0x01])
            try #expect(parser.read(bytes: 2) == [0x02, 0x03])
            parser.reset()
            try #expect(parser.read(bytes: 1) == [0x01])
        }
    }
    
    // MARK: - Data storage starting with index >0
    
    @Test
    func read_DataIndicesOffset() async throws {
        let rawData: [UInt8] = [0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04]
        let data = rawData[3 ... 6]
        
        // .read - byte by byte
        try data.withPointerDataParser { parser in
            #expect(parser.readOffset == 0)
            try #expect(parser.read(bytes: 1) == [0x01])
            try #expect(parser.read(bytes: 1) == [0x02])
            try #expect(parser.read(bytes: 1) == [0x03])
            try #expect(parser.read(bytes: 1) == [0x04])
            #expect(throws: (any Error).self) { try parser.read(bytes: 1) }
        }
        
        // .read - nil read - return all remaining bytes
        try data.withPointerDataParser { parser in
            try #expect(parser.read() == [0x01, 0x02, 0x03, 0x04])
            #expect(throws: (any Error).self) { try parser.read(bytes: 1) }
        }
        
        // .read - zero count read - return empty data, not nil
        try data.withPointerDataParser { parser in
            try #expect(parser.read(bytes: 0) == [])
        }
        
        // .read - read overflow - return nil
        data.withPointerDataParser { parser in
            #expect(throws: (any Error).self) { try parser.read(bytes: 5) }
        }
    }
    
    @Test
    func nonAdvancingRead_DataIndicesOffset() async throws {
        let rawData: [UInt8] = [0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04]
        let data = rawData[3 ... 6]
        
        // .nonAdvancingRead - nil read - return all remaining bytes
        try data.withPointerDataParser { parser in
            try #expect(parser.nonAdvancingRead() == [0x01, 0x02, 0x03, 0x04])
            try #expect(parser.read(bytes: 1) == [0x01])
        }
        
        // .nonAdvancingRead - read byte counts
        try data.withPointerDataParser { parser in
            try #expect(parser.nonAdvancingRead(bytes: 1) == [0x01])
            try #expect(parser.nonAdvancingRead(bytes: 2) == [0x01, 0x02])
        }
        
        // .nonAdvancingRead - read overflow - return nil
        try data.withPointerDataParser { parser in
            #expect(throws: (any Error).self) { try parser.nonAdvancingRead(bytes: 5) }
            try #expect(parser.read(bytes: 1) == [0x01])
        }
        
        // .nonAdvancingRead - read overflow - return nil
        data.withPointerDataParser { parser in
            #expect(throws: (any Error).self) { try parser.read(bytes: 8) }
        }
    }
    
    @Test
    func advanceBy_DataIndicesOffset() async throws {
        let rawData: [UInt8] = [0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04]
        let data = rawData[3 ... 6]
        
        // advanceBy
        try data.withPointerDataParser { parser in
            parser.advanceBy(1)
            try #expect(parser.read(bytes: 1) == [0x02])
        }
    }
    
    @Test
    func reset_DataIndicesOffset() async throws {
        let rawData: [UInt8] = [0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04]
        let data = rawData[3 ... 6]
        
        // reset
        try data.withPointerDataParser { parser in
            try #expect(parser.read(bytes: 1) == [0x01])
            try #expect(parser.read(bytes: 2) == [0x02, 0x03])
            parser.reset()
            try #expect(parser.read(bytes: 1) == [0x01])
        }
    }
    
    @Test
    func withPointerDataParser() async throws {
        let data: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        
        try data.withPointerDataParser { parser in
            #expect(parser.readOffset == 0)
            try #expect(parser.read(bytes: 1) == [0x01])
            try #expect(parser.read(bytes: 1) == [0x02])
            try #expect(parser.read(bytes: 1) == [0x03])
            try #expect(parser.read(bytes: 1) == [0x04])
            #expect(throws: (any Error).self) { try parser.read(bytes: 1) }
        }
        
        struct TestError: Error { }
        
        #expect(throws: (any Error).self) {
            try data.withPointerDataParser { parser in
                throw TestError()
            }
        }
    }
    
    @Test
    func withPointerDataParser_ReturnsValue() async throws {
        let data: [UInt8] = [0x01, 0x02, 0x03, 0x04]

        #if swift(>=5.7)
        let getByte = try data.withPointerDataParser { parser in
            _ = try parser.readByte()
            return try parser.readByte()
        }
        #else
        let getByte: UInt8 = try data.withPointerDataParser { parser in
            _ = try parser.readByte()
            return try parser.readByte()
        }
        #endif

        #expect(getByte == 0x02)
    }
}

#endif
