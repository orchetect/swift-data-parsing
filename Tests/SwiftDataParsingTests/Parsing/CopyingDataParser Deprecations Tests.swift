//
//  CopyingDataParser Deprecations Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import Foundation
import SwiftDataParsing
import Testing

@Suite struct CopyingDataParser_Deprecations_Tests {
    // MARK: - API Changes from swift-extensions 2.0.0
    
    @Test
    func deprecationTest() async throws {
        let data = Data([0x01, 0x02])
        
        // old type name, expect a fixit to show on this line to use new data parser API
        var parser = DataReader(data)
        
        #expect(try parser.readByte() == 0x01)
        #expect(try parser.readByte() == 0x02)
        #expect((try? parser.readByte()) == nil)
    }
}

#endif
