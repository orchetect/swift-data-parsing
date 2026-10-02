//
//  FloatToStringFormatStyle Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Testing
import SwiftDataParsing

/// This suite tests:
/// - `FloatToStringFormatStyle` static constructors
/// - Basic string formatting results
@Suite
struct FloatToStringFormatStyle_Tests {
    @Test
    func double() throws {
        #expect(formatted(123.5 as Double, format: .string) == "123.5")
    }

    @Test
    func float() throws {
        #expect(formatted(123.5 as Float, format: .string) == "123.5")
    }

    @Test
    func float16() throws {
        #expect(formatted(123.5 as Float16, format: .string) == "123.5")
    }
}
