//
//  StringToIntParseStrategy Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Testing
import SwiftDataParsing

/// This suite tests:
/// - `StringToIntParseStrategy` static constructors
/// - String parsing results
@Suite
struct StringToIntParseStrategy_Tests {
    @Test
    func int() throws {
        #expect(try parsed("123", strategy: .int) == 123 as Int)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .int)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .int)
        }
    }

    // (Since this initializer is shared for all associated integer types, we don't need to repeat this
    // test for every integer type in this test suite.)
    @Test
    func int_init_encoding() throws {
        #expect(StringToIntParseStrategy<Int>(options: []).options == [])
        #expect(StringToIntParseStrategy<Int>(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int_staticConstructors() throws {
        #expect(StringToIntParseStrategy.int(options: []).options == [])
        #expect(StringToIntParseStrategy.int(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int_encodingComposition() throws {
        #expect(StringToIntParseStrategy.int.options([]).options == [])
        #expect(StringToIntParseStrategy.int.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func int8() throws {
        #expect(try parsed("123", strategy: .int8) == 123 as Int8)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .int8)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .int8)
        }
    }

    @Test
    func int8_staticConstructors() throws {
        #expect(StringToIntParseStrategy.int8(options: []).options == [])
        #expect(StringToIntParseStrategy.int8(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int8_encodingComposition() throws {
        #expect(StringToIntParseStrategy.int8.options([]).options == [])
        #expect(StringToIntParseStrategy.int8.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func int16() throws {
        #expect(try parsed("123", strategy: .int16) == 123 as Int16)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .int16)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .int16)
        }
    }

    @Test
    func int16_staticConstructors() throws {
        #expect(StringToIntParseStrategy.int16(options: []).options == [])
        #expect(StringToIntParseStrategy.int16(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int16_encodingComposition() throws {
        #expect(StringToIntParseStrategy.int16.options([]).options == [])
        #expect(StringToIntParseStrategy.int16.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func int32() throws {
        #expect(try parsed("123", strategy: .int32) == 123 as Int32)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .int32)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .int32)
        }
    }

    @Test
    func int32_staticConstructors() throws {
        #expect(StringToIntParseStrategy.int32(options: []).options == [])
        #expect(StringToIntParseStrategy.int32(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int32_encodingComposition() throws {
        #expect(StringToIntParseStrategy.int32.options([]).options == [])
        #expect(StringToIntParseStrategy.int32.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func int64() throws {
        #expect(try parsed("123", strategy: .int64) == 123 as Int64)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .int64)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .int64)
        }
    }

    @Test
    func int64_staticConstructors() throws {
        #expect(StringToIntParseStrategy.int64(options: []).options == [])
        #expect(StringToIntParseStrategy.int64(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int64_encodingComposition() throws {
        #expect(StringToIntParseStrategy.int64.options([]).options == [])
        #expect(StringToIntParseStrategy.int64.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt() throws {
        #expect(try parsed("123", strategy: .uInt) == 123 as UInt)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .uInt)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .uInt)
        }
    }

    @Test
    func uInt_staticConstructors() throws {
        #expect(StringToIntParseStrategy.uInt(options: []).options == [])
        #expect(StringToIntParseStrategy.uInt(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt_encodingComposition() throws {
        #expect(StringToIntParseStrategy.uInt.options([]).options == [])
        #expect(StringToIntParseStrategy.uInt.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt8() throws {
        #expect(try parsed("123", strategy: .uInt8) == 123 as UInt8)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .uInt8)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .uInt8)
        }
    }

    @Test
    func uInt8_staticConstructors() throws {
        #expect(StringToIntParseStrategy.uInt8(options: []).options == [])
        #expect(StringToIntParseStrategy.uInt8(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt8_encodingComposition() throws {
        #expect(StringToIntParseStrategy.uInt8.options([]).options == [])
        #expect(StringToIntParseStrategy.uInt8.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt16() throws {
        #expect(try parsed("123", strategy: .uInt16) == 123 as UInt16)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .uInt16)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .uInt16)
        }
    }

    @Test
    func uInt16_staticConstructors() throws {
        #expect(StringToIntParseStrategy.uInt16(options: []).options == [])
        #expect(StringToIntParseStrategy.uInt16(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt16_encodingComposition() throws {
        #expect(StringToIntParseStrategy.uInt16.options([]).options == [])
        #expect(StringToIntParseStrategy.uInt16.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt32() throws {
        #expect(try parsed("123", strategy: .uInt32) == 123 as UInt32)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .uInt32)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .uInt32)
        }
    }

    @Test
    func uInt32_staticConstructors() throws {
        #expect(StringToIntParseStrategy.uInt32(options: []).options == [])
        #expect(StringToIntParseStrategy.uInt32(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt32_encodingComposition() throws {
        #expect(StringToIntParseStrategy.uInt32.options([]).options == [])
        #expect(StringToIntParseStrategy.uInt32.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt64() throws {
        #expect(try parsed("123", strategy: .uInt64) == 123 as UInt64)

        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .uInt64)
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .uInt64)
        }
    }

    @Test
    func uInt64_staticConstructors() throws {
        #expect(StringToIntParseStrategy.uInt64(options: []).options == [])
        #expect(StringToIntParseStrategy.uInt64(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt64_encodingComposition() throws {
        #expect(StringToIntParseStrategy.uInt64.options([]).options == [])
        #expect(StringToIntParseStrategy.uInt64.options([.allowBool]).options == [.allowBool])
    }

    // MARK: - `ParseOption`

    @Test
    func int_noOptions() throws {
        let options: Set<StringToIntParseStrategy<Int>.ParseOption> = []

        // positive numbers
        #expect(try parsed("123", strategy: .int(options: options)) == 123)
        #expect(try parsed("123.0", strategy: .int(options: options)) == 123)
        #expect(throws: ParseStrategyError.parseError) {
            try parsed("123.1", strategy: .int(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            try parsed("123.9", strategy: .int(options: options))
        }

        // negative numbers
        #expect(try parsed("-123", strategy: .int(options: options)) == -123)
        #expect(try parsed("-123.0", strategy: .int(options: options)) == -123)
        #expect(throws: ParseStrategyError.parseError) {
            try parsed("-123.1", strategy: .int(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            try parsed("-123.9", strategy: .int(options: options))
        }

        // bool strings
        #expect(throws: ParseStrategyError.parseError) { try parsed("true", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("false", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("TRUE", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("FALSE", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("t", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("f", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("T", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("F", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("yes", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("no", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("YES", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("NO", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("y", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("n", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("Y", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("N", strategy: .int(options: options)) }

        // non-numbers
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .int(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .int(options: options))
        }
    }

    @Test
    func int_allowNonWholeFloats() throws {
        let options: Set<StringToIntParseStrategy<Int>.ParseOption> = [.allowNonWholeFloats]

        // positive numbers
        #expect(try parsed("123", strategy: .int(options: options)) == 123)
        #expect(try parsed("123.0", strategy: .int(options: options)) == 123)
        #expect(try parsed("123.1", strategy: .int(options: options)) == 123)
        #expect(try parsed("123.9", strategy: .int(options: options)) == 123)

        // negative numbers
        #expect(try parsed("-123", strategy: .int(options: options)) == -123)
        #expect(try parsed("-123.0", strategy: .int(options: options)) == -123)
        #expect(try parsed("-123.1", strategy: .int(options: options)) == -123)
        #expect(try parsed("-123.9", strategy: .int(options: options)) == -123)

        // bool strings
        #expect(throws: ParseStrategyError.parseError) { try parsed("true", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("false", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("TRUE", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("FALSE", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("t", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("f", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("T", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("F", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("yes", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("no", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("YES", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("NO", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("y", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("n", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("Y", strategy: .int(options: options)) }
        #expect(throws: ParseStrategyError.parseError) { try parsed("N", strategy: .int(options: options)) }

        // non-numbers
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .int(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .int(options: options))
        }
    }

    @Test
    func int_allowBool() throws {
        let options: Set<StringToIntParseStrategy<Int>.ParseOption> = [.allowBool]

        // positive numbers
        #expect(try parsed("123", strategy: .int(options: options)) == 123)
        #expect(try parsed("123.0", strategy: .int(options: options)) == 123)
        #expect(throws: ParseStrategyError.parseError) {
            try parsed("123.1", strategy: .int(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            try parsed("123.9", strategy: .int(options: options))
        }

        // negative numbers
        #expect(try parsed("-123", strategy: .int(options: options)) == -123)
        #expect(try parsed("-123.0", strategy: .int(options: options)) == -123)
        #expect(throws: ParseStrategyError.parseError) {
            try parsed("-123.1", strategy: .int(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            try parsed("-123.9", strategy: .int(options: options))
        }

        // bool strings
        #expect(try parsed("true", strategy: .int(options: options)) == 1)
        #expect(try parsed("false", strategy: .int(options: options)) == 0)
        #expect(try parsed("TRUE", strategy: .int(options: options)) == 1)
        #expect(try parsed("FALSE", strategy: .int(options: options)) == 0)
        #expect(try parsed("t", strategy: .int(options: options)) == 1)
        #expect(try parsed("f", strategy: .int(options: options)) == 0)
        #expect(try parsed("T", strategy: .int(options: options)) == 1)
        #expect(try parsed("F", strategy: .int(options: options)) == 0)
        #expect(try parsed("yes", strategy: .int(options: options)) == 1)
        #expect(try parsed("no", strategy: .int(options: options)) == 0)
        #expect(try parsed("YES", strategy: .int(options: options)) == 1)
        #expect(try parsed("NO", strategy: .int(options: options)) == 0)
        #expect(try parsed("y", strategy: .int(options: options)) == 1)
        #expect(try parsed("n", strategy: .int(options: options)) == 0)
        #expect(try parsed("Y", strategy: .int(options: options)) == 1)
        #expect(try parsed("N", strategy: .int(options: options)) == 0)

        // non-numbers
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .int(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .int(options: options))
        }
    }

    @Test
    func int_allowNonWholeFloats_allowBool() throws {
        let options: Set<StringToIntParseStrategy<Int>.ParseOption> = [.allowNonWholeFloats, .allowBool]

        // positive numbers
        #expect(try parsed("123", strategy: .int(options: options)) == 123)
        #expect(try parsed("123.0", strategy: .int(options: options)) == 123)
        #expect(try parsed("123.1", strategy: .int(options: options)) == 123)
        #expect(try parsed("123.9", strategy: .int(options: options)) == 123)

        // negative numbers
        #expect(try parsed("-123", strategy: .int(options: options)) == -123)
        #expect(try parsed("-123.0", strategy: .int(options: options)) == -123)
        #expect(try parsed("-123.1", strategy: .int(options: options)) == -123)
        #expect(try parsed("-123.9", strategy: .int(options: options)) == -123)

        // bool strings
        #expect(try parsed("true", strategy: .int(options: options)) == 1)
        #expect(try parsed("false", strategy: .int(options: options)) == 0)
        #expect(try parsed("TRUE", strategy: .int(options: options)) == 1)
        #expect(try parsed("FALSE", strategy: .int(options: options)) == 0)
        #expect(try parsed("t", strategy: .int(options: options)) == 1)
        #expect(try parsed("f", strategy: .int(options: options)) == 0)
        #expect(try parsed("T", strategy: .int(options: options)) == 1)
        #expect(try parsed("F", strategy: .int(options: options)) == 0)
        #expect(try parsed("yes", strategy: .int(options: options)) == 1)
        #expect(try parsed("no", strategy: .int(options: options)) == 0)
        #expect(try parsed("YES", strategy: .int(options: options)) == 1)
        #expect(try parsed("NO", strategy: .int(options: options)) == 0)
        #expect(try parsed("y", strategy: .int(options: options)) == 1)
        #expect(try parsed("n", strategy: .int(options: options)) == 0)
        #expect(try parsed("Y", strategy: .int(options: options)) == 1)
        #expect(try parsed("N", strategy: .int(options: options)) == 0)

        // non-numbers
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("", strategy: .int(options: options))
        }
        #expect(throws: ParseStrategyError.parseError) {
            _ = try parsed("abc", strategy: .int(options: options))
        }
    }
}
