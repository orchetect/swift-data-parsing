//
//  StringToArrayParseStrategy Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Testing
import SwiftDataParsing

/// This suite tests:
/// - `[Type]` static constructors
/// - String parsing results
@Suite
struct StringToArrayParseStrategy_Tests {
    @Test
    func concreteType_defaultSeparator() throws {
        let strategy = StringToArrayParseStrategy(of: Int.self, transform: .int)

        #expect(try parsed("", strategy: strategy) == [])
        #expect(try parsed("1", strategy: strategy) == [1])
        #expect(try parsed("1,2", strategy: strategy) == [1, 2])
        #expect(try parsed("3,1,2", strategy: strategy) == [3, 1, 2])

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed(" ", strategy: strategy)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: strategy)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed(",", strategy: strategy)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed(",1,2,", strategy: strategy)
        }
    }

    @Test
    func concreteType_customSeparator() throws {
        let strategy = StringToArrayParseStrategy(of: Int.self, separator: "|", transform: .int)

        #expect(try parsed("", strategy: strategy) == [])
        #expect(try parsed("1", strategy: strategy) == [1])
        #expect(try parsed("1|2", strategy: strategy) == [1, 2])
        #expect(try parsed("3|1|2", strategy: strategy) == [3, 1, 2])

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed(" ", strategy: strategy)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: strategy)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("|", strategy: strategy)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("|1|2|", strategy: strategy)
        }
    }

    @Test
    func concreteStatic_defaultSeparator() throws {
        #expect(try parsed("", strategy: [Int].stringParseStrategy(transform: .int)) == [])
        #expect(try parsed("1", strategy: [Int].stringParseStrategy(transform: .int)) == [1])
        #expect(try parsed("1,2", strategy: [Int].stringParseStrategy(transform: .int)) == [1, 2])
        #expect(try parsed("3,1,2", strategy: [Int].stringParseStrategy(transform: .int)) == [3, 1, 2])
    }

    @Test
    func concreteStatic_customSeparator() throws {
        #expect(try parsed("", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [])
        #expect(try parsed("1", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [1])
        #expect(try parsed("1|2", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [1, 2])
        #expect(try parsed("3|1|2", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [3, 1, 2])
    }

    @Test
    func separatorComposition() throws {
        #expect(try parsed("", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [])
        #expect(try parsed("1", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [1])
        #expect(try parsed("1|2", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [1, 2])
        #expect(try parsed("3|1|2", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [3, 1, 2])

    }
}
