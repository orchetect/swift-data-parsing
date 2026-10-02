//
//  StringToStringSetParseStrategy Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Testing
import SwiftDataParsing

/// This suite tests:
/// - `StringToStringSetParseStrategy` static constructors
/// - String parsing results
@Suite
struct StringToStringSetParseStrategy_Tests {
    @Test
    func staticConstructor_defaultSeparator() throws {
        #expect(try parsed("", strategy: .stringSet()) == [])
        #expect(try parsed(" ", strategy: .stringSet()) == [" "])
        #expect(try parsed(",", strategy: .stringSet()) == [""]) // "" is de-duped
        #expect(try parsed("foo", strategy: .stringSet()) == ["foo"])
        #expect(try parsed("foo,bar", strategy: .stringSet()) == ["foo", "bar"])
        #expect(try parsed("foo,foo,bar", strategy: .stringSet()) == ["foo", "bar"]) // "foo" is de-duped
        #expect(try parsed(",foo,bar,", strategy: .stringSet()) == ["", "foo", "bar"]) // "" is de-duped
    }

    @Test
    func staticConstructor_customSeparator() throws {
        #expect(try parsed("", strategy: .stringSet(separator: "|")) == [])
        #expect(try parsed(" ", strategy: .stringSet(separator: "|")) == [" "])
        #expect(try parsed("|", strategy: .stringSet(separator: "|")) == [""]) // "" is de-duped
        #expect(try parsed("foo", strategy: .stringSet(separator: "|")) == ["foo"])
        #expect(try parsed("foo|bar", strategy: .stringSet(separator: "|")) == ["foo", "bar"])
        #expect(try parsed("foo|foo|bar", strategy: .stringSet(separator: "|")) == ["foo", "bar"]) // "foo" is de-duped
        #expect(try parsed("|foo|bar|", strategy: .stringSet(separator: "|")) == ["", "foo", "bar"]) // "" is de-duped
    }

    @Test
    func composition_separator_defaultSeparator() throws {
        #expect(try parsed("", strategy: .stringSet) == [])
        #expect(try parsed(" ", strategy: .stringSet) == [" "])
        #expect(try parsed(",", strategy: .stringSet) == [""]) // "" is de-duped
        #expect(try parsed("foo", strategy: .stringSet) == ["foo"])
        #expect(try parsed("foo,bar", strategy: .stringSet) == ["foo", "bar"])
        #expect(try parsed("foo,foo,bar", strategy: .stringSet) == ["foo", "bar"]) // "foo" is de-duped
        #expect(try parsed(",foo,bar,", strategy: .stringSet) == ["", "foo", "bar"]) // "" is de-duped
    }

    @Test
    func composition_separator_customSeparator() throws {
        #expect(try parsed("", strategy: .stringSet.separator("|")) == [])
        #expect(try parsed(" ", strategy: .stringSet.separator("|")) == [" "])
        #expect(try parsed("|", strategy: .stringSet.separator("|")) == [""]) // "" is de-duped
        #expect(try parsed("foo", strategy: .stringSet.separator("|")) == ["foo"])
        #expect(try parsed("foo|bar", strategy: .stringSet.separator("|")) == ["foo", "bar"])
        #expect(try parsed("foo|foo|bar", strategy: .stringSet.separator("|")) == ["foo", "bar"]) // "foo" is de-duped
        #expect(try parsed("|foo|bar|", strategy: .stringSet.separator("|")) == ["", "foo", "bar"]) // "" is de-duped
    }
}
