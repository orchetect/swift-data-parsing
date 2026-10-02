//
//  StringToStringParseStrategy Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Testing
import SwiftDataParsing

/// This suite tests:
/// - `StringToStringParseStrategy`:
///   - Static constructors
///   - All `ParseOption` cases and combinations
/// - String parsing results
@Suite
struct StringToStringParseStrategy_Tests {
    @Test
    func string() throws {
        #expect(try parsed("", strategy: .string) == "")
        #expect(try parsed("foo", strategy: .string) == "foo")
    }

    @Test
    func init_options() throws {
        #expect(StringToStringParseStrategy(options: []).options == [])
        #expect(StringToStringParseStrategy(options: [.rejectEmpty]).options == [.rejectEmpty])
    }

    @Test
    func staticConstructors() throws {
        #expect(StringToStringParseStrategy.string(options: []).options == [])
        #expect(StringToStringParseStrategy.string(options: [.rejectEmpty]).options == [.rejectEmpty])
    }

    @Test
    func optionsComposition() throws {
        #expect(StringToStringParseStrategy.string.options([]).options == [])
        #expect(StringToStringParseStrategy.string.options([.rejectEmpty]).options == [.rejectEmpty])
    }

    @Test
    func string_noOptions() throws {
        let options: Set<StringToStringParseStrategy.ParseOption> = []

        #expect(try parsed("", strategy: .string(options: options)) == "")
        #expect(try parsed(" ", strategy: .string(options: options)) == " ")
        #expect(try parsed(" \t ", strategy: .string(options: options)) == " \t ")
        #expect(try parsed(" \t\n ", strategy: .string(options: options)) == " \t\n ")
        #expect(try parsed(" abc 123 !@#$%^&*() ", strategy: .string(options: options)) == " abc 123 !@#$%^&*() ")
    }

    @Test
    func string_rejectEmpty() throws {
        let options: Set<StringToStringParseStrategy.ParseOption> = [.rejectEmpty]

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .string(options: options))
        }
        #expect(try parsed(" ", strategy: .string(options: options)) == " ")
        #expect(try parsed(" \t ", strategy: .string(options: options)) == " \t ")
        #expect(try parsed(" \t\n ", strategy: .string(options: options)) == " \t\n ")
        #expect(try parsed(" abc 123 !@#$%^&*() ", strategy: .string(options: options)) == " abc 123 !@#$%^&*() ")
    }

    @Test
    func string_rejectWhitespaceOnly() throws {
        let options: Set<StringToStringParseStrategy.ParseOption> = [.rejectWhitespaceOnly]

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .string(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            try parsed(" ", strategy: .string(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            try parsed(" \t ", strategy: .string(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            try parsed(" \t\n ", strategy: .string(options: options))
        }
        #expect(try parsed(" abc 123 !@#$%^&*() ", strategy: .string(options: options)) == " abc 123 !@#$%^&*() ")
    }
}
