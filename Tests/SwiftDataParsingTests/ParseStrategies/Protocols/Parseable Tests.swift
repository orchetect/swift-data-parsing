//
//  Parseable Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftDataParsing

@Suite
struct Parseable_Tests {
    // MARK: - Built-In Behavior

    // Check behavior of `init(_:strategy:)` where implemented on Swift/Foundation's built-in types
    // there are other relevant standard types, but testing all of them is not necessary.
    // this test is just a form of a staging area to establish or check behaviors.

    @Test
    func builtIn_Decimal() throws {
        #expect(try Decimal("1.23", strategy: Decimal.ParseStrategy(format: .number)) == 1.23)
    }

    @Test
    func builtIn_Int() throws {
        // `Int` accepts parse strategies that return a `BinaryInteger`
        #expect(try Int("123", strategy: .int) == 123)
        #expect(try Int("123", strategy: .int8) == 123)
        #expect(try Int("123", strategy: .int16) == 123)
        #expect(try Int("123", strategy: .int32) == 123)
        #expect(try Int("123", strategy: .int64) == 123)
    }

    @Test
    func builtIn_Int32() throws {
        // various `BinaryInteger` types including `Int32` accept parse strategies that return a `BinaryInteger`
        #expect(try Int32("123", strategy: .int) == 123)
        #expect(try Int32("123", strategy: .int8) == 123)
        #expect(try Int32("123", strategy: .int16) == 123)
        #expect(try Int32("123", strategy: .int32) == 123)
        #expect(try Int32("123", strategy: .int64) == 123)
    }

    @Test
    func builtIn_Double() throws {
        // `Double` accepts parse strategies that return a `BinaryFloatingPoint`
        #expect(try Double("123.5", strategy: .double) == 123.5)
        #expect(try Double("123.5", strategy: .float) == 123.5)
        #expect(try Double("123.5", strategy: .float16) == 123.5)
    }

    // MARK: - Standard Type Conformances

    @Test
    func parseable_String() throws {
        #expect(try String("foo", strategy: .string) == "foo")
    }

    @Test
    func parseable_StringArray() throws {
        #expect(try [String]("foo,bar", strategy: .stringArray) == ["foo", "bar"])
    }

    @Test
    func parseable_IntArray() throws {
        #expect(try [Int]("1,2,3", strategy: [Int].stringParseStrategy(transform: .int)) == [1, 2, 3])
    }

    @Test
    func parseable_StringSet() throws {
        #expect(try Set<String>("foo,bar", strategy: .stringSet) == ["foo", "bar"])
    }

    @Test
    func parseable_IntSet() throws {
        #expect(try Set<Int>("1,2,3", strategy: Set<Int>.stringParseStrategy(transform: .int)) == [1, 2, 3])
    }
}
