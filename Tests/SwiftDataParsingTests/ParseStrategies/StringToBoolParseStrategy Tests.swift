//
//  StringToBoolParseStrategy Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Testing
import SwiftDataParsing

/// This suite tests:
/// - `StringToBoolParseStrategy`:
///   - Static constructors
///   - All `ParseOption` cases and combinations
/// - String parsing results
@Suite
struct StringToBoolParseStrategy_Tests {
    @Test
    func bool() throws {
        #expect(try parsed("true", strategy: .bool) == true)
        #expect(try parsed("false", strategy: .bool) == false)
    }

    @Test
    func init_options() throws {
        #expect(StringToBoolParseStrategy(options: []).options == [])
        #expect(StringToBoolParseStrategy(options: [.allowOutOfBoundsNumbers]).options == [.allowOutOfBoundsNumbers])
    }

    @Test
    func staticConstructors() throws {
        #expect(StringToBoolParseStrategy.bool(options: []).options == [])
        #expect(StringToBoolParseStrategy.bool(options: [.allowOutOfBoundsNumbers]).options == [.allowOutOfBoundsNumbers])
    }

    @Test
    func optionsComposition() throws {
        #expect(StringToBoolParseStrategy.bool.options([]).options == [])
        #expect(StringToBoolParseStrategy.bool.options([.allowOutOfBoundsNumbers]).options == [.allowOutOfBoundsNumbers])
    }

    @Test
    func bool_noOptions() throws {
        let options: Set<StringToBoolParseStrategy.ParseOption> = []

        #expect(try parsed("true", strategy: .bool(options: options)) == true)
        #expect(try parsed("false", strategy: .bool(options: options)) == false)
        #expect(try parsed("TRUE", strategy: .bool(options: options)) == true)
        #expect(try parsed("FALSE", strategy: .bool(options: options)) == false)
        #expect(try parsed("t", strategy: .bool(options: options)) == true)
        #expect(try parsed("f", strategy: .bool(options: options)) == false)
        #expect(try parsed("T", strategy: .bool(options: options)) == true)
        #expect(try parsed("F", strategy: .bool(options: options)) == false)
        #expect(try parsed("yes", strategy: .bool(options: options)) == true)
        #expect(try parsed("no", strategy: .bool(options: options)) == false)
        #expect(try parsed("YES", strategy: .bool(options: options)) == true)
        #expect(try parsed("NO", strategy: .bool(options: options)) == false)
        #expect(try parsed("y", strategy: .bool(options: options)) == true)
        #expect(try parsed("n", strategy: .bool(options: options)) == false)
        #expect(try parsed("Y", strategy: .bool(options: options)) == true)
        #expect(try parsed("N", strategy: .bool(options: options)) == false)
        #expect(try parsed("1", strategy: .bool(options: options)) == true)
        #expect(try parsed("0", strategy: .bool(options: options)) == false)
        #expect(try parsed("1.0", strategy: .bool(options: options)) == true)
        #expect(try parsed("0.0", strategy: .bool(options: options)) == false)
        #expect(try parsed("1.00", strategy: .bool(options: options)) == true)
        #expect(try parsed("0.00", strategy: .bool(options: options)) == false)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .bool(options: options))
        }

        // case mismatch
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("True", strategy: .bool(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("False", strategy: .bool(options: options))
        }

        // out of bounds numbers
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("2.5", strategy: .bool(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("2", strategy: .bool(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("-1", strategy: .bool(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("-1.5", strategy: .bool(options: options))
        }
    }

    @Test
    func bool_caseInsensitive() throws {
        let options: Set<StringToBoolParseStrategy.ParseOption> = [.caseInsensitive]

        #expect(try parsed("true", strategy: .bool(options: options)) == true)
        #expect(try parsed("false", strategy: .bool(options: options)) == false)
        #expect(try parsed("TRUE", strategy: .bool(options: options)) == true)
        #expect(try parsed("FALSE", strategy: .bool(options: options)) == false)
        #expect(try parsed("t", strategy: .bool(options: options)) == true)
        #expect(try parsed("f", strategy: .bool(options: options)) == false)
        #expect(try parsed("T", strategy: .bool(options: options)) == true)
        #expect(try parsed("F", strategy: .bool(options: options)) == false)
        #expect(try parsed("yes", strategy: .bool(options: options)) == true)
        #expect(try parsed("no", strategy: .bool(options: options)) == false)
        #expect(try parsed("YES", strategy: .bool(options: options)) == true)
        #expect(try parsed("NO", strategy: .bool(options: options)) == false)
        #expect(try parsed("y", strategy: .bool(options: options)) == true)
        #expect(try parsed("n", strategy: .bool(options: options)) == false)
        #expect(try parsed("Y", strategy: .bool(options: options)) == true)
        #expect(try parsed("N", strategy: .bool(options: options)) == false)
        #expect(try parsed("1", strategy: .bool(options: options)) == true)
        #expect(try parsed("0", strategy: .bool(options: options)) == false)
        #expect(try parsed("1.0", strategy: .bool(options: options)) == true)
        #expect(try parsed("0.0", strategy: .bool(options: options)) == false)
        #expect(try parsed("1.00", strategy: .bool(options: options)) == true)
        #expect(try parsed("0.00", strategy: .bool(options: options)) == false)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .bool(options: options))
        }

        // case mismatch
        #expect(try parsed("True", strategy: .bool(options: options)) == true)
        #expect(try parsed("False", strategy: .bool(options: options)) == false)

        // out of bounds numbers
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("2.5", strategy: .bool(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("2", strategy: .bool(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("-1", strategy: .bool(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("-1.5", strategy: .bool(options: options))
        }
    }

    @Test
    func bool_allowOutOfBoundsNumbers() throws {
        let options: Set<StringToBoolParseStrategy.ParseOption> = [.allowOutOfBoundsNumbers]

        #expect(try parsed("true", strategy: .bool(options: options)) == true)
        #expect(try parsed("false", strategy: .bool(options: options)) == false)
        #expect(try parsed("TRUE", strategy: .bool(options: options)) == true)
        #expect(try parsed("FALSE", strategy: .bool(options: options)) == false)
        #expect(try parsed("t", strategy: .bool(options: options)) == true)
        #expect(try parsed("f", strategy: .bool(options: options)) == false)
        #expect(try parsed("T", strategy: .bool(options: options)) == true)
        #expect(try parsed("F", strategy: .bool(options: options)) == false)
        #expect(try parsed("yes", strategy: .bool(options: options)) == true)
        #expect(try parsed("no", strategy: .bool(options: options)) == false)
        #expect(try parsed("YES", strategy: .bool(options: options)) == true)
        #expect(try parsed("NO", strategy: .bool(options: options)) == false)
        #expect(try parsed("y", strategy: .bool(options: options)) == true)
        #expect(try parsed("n", strategy: .bool(options: options)) == false)
        #expect(try parsed("Y", strategy: .bool(options: options)) == true)
        #expect(try parsed("N", strategy: .bool(options: options)) == false)
        #expect(try parsed("1", strategy: .bool(options: options)) == true)
        #expect(try parsed("0", strategy: .bool(options: options)) == false)
        #expect(try parsed("1.0", strategy: .bool(options: options)) == true)
        #expect(try parsed("0.0", strategy: .bool(options: options)) == false)
        #expect(try parsed("1.00", strategy: .bool(options: options)) == true)
        #expect(try parsed("0.00", strategy: .bool(options: options)) == false)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .bool(options: options))
        }

        // case mismatch
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("True", strategy: .bool(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("False", strategy: .bool(options: options))
        }

        // out of bounds numbers
        #expect(try parsed("2.5", strategy: .bool(options: options)) == true)
        #expect(try parsed("2", strategy: .bool(options: options)) == true)
        #expect(try parsed("-1", strategy: .bool(options: options)) == false)
        #expect(try parsed("-1.5", strategy: .bool(options: options)) == false)
    }

    @Test
    func bool_caseInsensitive_allowOutOfBoundsNumbers() throws {
        let options: Set<StringToBoolParseStrategy.ParseOption> = [.caseInsensitive, .allowOutOfBoundsNumbers]

        #expect(try parsed("true", strategy: .bool(options: options)) == true)
        #expect(try parsed("false", strategy: .bool(options: options)) == false)
        #expect(try parsed("TRUE", strategy: .bool(options: options)) == true)
        #expect(try parsed("FALSE", strategy: .bool(options: options)) == false)
        #expect(try parsed("t", strategy: .bool(options: options)) == true)
        #expect(try parsed("f", strategy: .bool(options: options)) == false)
        #expect(try parsed("T", strategy: .bool(options: options)) == true)
        #expect(try parsed("F", strategy: .bool(options: options)) == false)
        #expect(try parsed("yes", strategy: .bool(options: options)) == true)
        #expect(try parsed("no", strategy: .bool(options: options)) == false)
        #expect(try parsed("YES", strategy: .bool(options: options)) == true)
        #expect(try parsed("NO", strategy: .bool(options: options)) == false)
        #expect(try parsed("y", strategy: .bool(options: options)) == true)
        #expect(try parsed("n", strategy: .bool(options: options)) == false)
        #expect(try parsed("Y", strategy: .bool(options: options)) == true)
        #expect(try parsed("N", strategy: .bool(options: options)) == false)
        #expect(try parsed("1", strategy: .bool(options: options)) == true)
        #expect(try parsed("0", strategy: .bool(options: options)) == false)
        #expect(try parsed("1.0", strategy: .bool(options: options)) == true)
        #expect(try parsed("0.0", strategy: .bool(options: options)) == false)
        #expect(try parsed("1.00", strategy: .bool(options: options)) == true)
        #expect(try parsed("0.00", strategy: .bool(options: options)) == false)
        
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .bool(options: options))
        }

        // case mismatch
        #expect(try parsed("True", strategy: .bool(options: options)) == true)
        #expect(try parsed("False", strategy: .bool(options: options)) == false)

        // out of bounds numbers
        #expect(try parsed("2.5", strategy: .bool(options: options)) == true)
        #expect(try parsed("2", strategy: .bool(options: options)) == true)
        #expect(try parsed("-1", strategy: .bool(options: options)) == false)
        #expect(try parsed("-1.5", strategy: .bool(options: options)) == false)
    }
}
