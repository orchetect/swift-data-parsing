//
//  ArrayToStringFormatStyle Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftDataParsing

/// This suite tests:
/// - `[Type]` static constructor
/// - Basic string formatting results
///
/// Note that due to associated generics of the array's Element, there is no feasible way to offer
/// a standard static constructor extension on `FormatStyle`, as there is no way to express the constraints.
@Suite
struct ArrayToStringFormatStyle_Tests {
    @Test
    func concreteType_defaultSeparator() throws {
        let format = ArrayToStringFormatStyle(of: Int.self, transform: .string)

        #expect(formatted([] as [Int], format: format) == "")
        #expect(formatted([1], format: format) == "1")
        #expect(formatted([3, 1, 2], format: format) == "3,1,2")
    }

    @Test
    func concreteType_customSeparator() throws {
        let format = ArrayToStringFormatStyle(of: Int.self, separator: "|", transform: .string)

        #expect(formatted([] as [Int], format: format) == "")
        #expect(formatted([1], format: format) == "1")
        #expect(formatted([3, 1, 2], format: format) == "3|1|2")
    }

    @Test
    func concreteStatic_defaultSeparator() throws {
        #expect(formatted([] as [Int], format: [Int].stringFormatStyle(transform: .string)) == "")
        #expect(formatted([1], format: [Int].stringFormatStyle(transform: .string)) == "1")
        #expect(formatted([3, 1, 2], format: [Int].stringFormatStyle(transform: .string)) == "3,1,2")
    }

    @Test
    func concreteStatic_customSeparator() throws {
        #expect(formatted([] as [Int], format: [Int].stringFormatStyle(separator: "|", transform: .string)) == "")
        #expect(formatted([1], format: [Int].stringFormatStyle(separator: "|", transform: .string)) == "1")
        #expect(formatted([3, 1, 2], format: [Int].stringFormatStyle(separator: "|", transform: .string)) == "3|1|2")
    }

    @Test
    func separatorComposition() throws {
        #expect(formatted([] as [Int], format: [Int].stringFormatStyle(transform: .string).separator("|")) == "")
        #expect(formatted([1], format: [Int].stringFormatStyle(transform: .string).separator("|")) == "1")
        #expect(formatted([3, 1, 2], format: [Int].stringFormatStyle(transform: .string).separator("|")) == "3|1|2")
    }
}
