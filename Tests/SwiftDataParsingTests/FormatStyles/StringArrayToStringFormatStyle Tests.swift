//
//  StringArrayToStringFormatStyle Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftDataParsing

/// This suite tests:
/// - `StringArrayToStringFormatStyle` static constructor
/// - Basic string formatting results
@Suite
struct StringArrayToStringFormatStyle_Tests {
    @Test
    func staticConstructor_defaultSeparator() throws {
        #expect(formatted(["foo"], format: .string) == "foo")
        #expect(formatted(["foo", "bar"], format: .string) == "foo,bar")
    }

    @Test
    func staticConstructor_customSeparator() throws {
        #expect(formatted(["foo"], format: .string(separator: "|")) == "foo")
        #expect(formatted(["foo", "bar"], format: .string(separator: "|")) == "foo|bar")
    }

    @Test
    func separatorComposition() throws {
        #expect(formatted(["foo"], format: .string.separator("|")) == "foo")
        #expect(formatted(["foo", "bar"], format: .string.separator("|")) == "foo|bar")
    }
}
