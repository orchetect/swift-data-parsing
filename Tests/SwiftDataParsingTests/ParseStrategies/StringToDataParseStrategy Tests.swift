//
//  StringToDataParseStrategy Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftDataParsing

/// This suite tests:
/// - `StringToDataParseStrategy`:
///   - Static constructors
///   - Composition methods
///   - All `Encoding` encodings
/// - String parsing results
@Suite
struct StringToDataParseStrategy_Tests {
    @Test
    func concreteType_defaultEncoding() throws {
        // default uses Base64
        let strategy = StringToDataParseStrategy.data

        #expect(try strategy.parse("") == Data())
        #expect(try strategy.parse("AQI=") == Data([0x01, 0x02]))

        #expect(throws: ParseStrategyError.parseError) {
            _ = try strategy.parse("AQI")
        }
    }

    @Test
    func staticConstructor_defaultEncoding() throws {
        // default uses Base64
        #expect(try parsed("", strategy: .data) == Data())
        #expect(try parsed("AQI=", strategy: .data) == Data([0x01, 0x02]))
    }

    @Test
    func composition_encoding() throws {
        #expect(try parsed("", strategy: .data.encoding(.base64)) == Data())
        #expect(try parsed("AQI=", strategy: .data.encoding(.base64)) == Data([0x01, 0x02]))
    }

    @Test(arguments: StringToDataParseStrategy.Encoding.allCases)
    func allEncodings_constructors(encoding: StringToDataParseStrategy.Encoding) throws {
        switch encoding {
        case .base64:
            // struct init
            #expect(StringToDataParseStrategy(encoding: encoding).encoding == encoding)
            // composition method
            #expect(StringToDataParseStrategy.data.encoding(encoding).encoding == encoding)
        }
    }

    @Test(arguments: StringToDataParseStrategy.Encoding.allCases)
    func allEncodings_parse(encoding: StringToDataParseStrategy.Encoding) throws {
        // use a switch case on allCases for compiler enforcement of testing all encodings
        switch encoding {
        case .base64:
            let strategy = StringToDataParseStrategy(encoding: encoding)
            #expect(try strategy.parse("") == Data())
            #expect(try strategy.parse("AQI=") == Data([0x01, 0x02]))

            #expect(throws: ParseStrategyError.parseError) {
                _ = try strategy.parse("AQI")
            }
        }
    }
}
