//
//  StringToStringFormatStyle Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Testing
import SwiftDataParsing

/// This suite tests:
/// - `StringToStringFormatStyle` static constructors
/// - Basic string formatting results
@Suite
struct StringToStringFormatStyle_Tests {
    @Test
    func string() throws {
        #expect(formatted("", format: .string) == "")
        #expect(formatted("foo", format: .string) == "foo")
    }
}
