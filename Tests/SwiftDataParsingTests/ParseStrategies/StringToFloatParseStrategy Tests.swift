//
//  StringToFloatParseStrategy Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Testing
import SwiftDataParsing

/// This suite tests:
/// - `StringToFloatParseStrategy` static constructors
/// - String parsing results
@Suite
struct StringToFloatParseStrategy_Tests {
    @Test
    func double() throws {
        #expect(try parsed("123", strategy: .double) == 123 as Double)
        #expect(try parsed("123.5", strategy: .double) == 123.5 as Double)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .double)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .double)
        }
    }

    @Test
    func float() throws {
        #expect(try parsed("123", strategy: .float) == 123 as Float)
        #expect(try parsed("123.5", strategy: .float) == 123.5 as Float)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .float)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .float)
        }
    }

    @Test
    func float16() throws {
        #expect(try parsed("123", strategy: .float16) == 123 as Float16)
        #expect(try parsed("123.5", strategy: .float16) == 123.5 as Float16)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .float16)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .float16)
        }
    }
}
