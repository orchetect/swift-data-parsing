//
//  SetToStringFormatStyle Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftDataParsing

/// This suite tests:
/// - `Set<Type>` static constructor
/// - Basic string formatting results
///
/// Note that due to associated generics of the set's Element, there is no feasible way to offer
/// a standard static constructor extension on `FormatStyle`, as there is no way to express the constraints.
@Suite
struct SetToStringFormatStyle_Tests {
    @Test
    func concreteType_defaultSeparator() throws {
        let format = SetToStringFormatStyle(of: Int.self, transform: .string)

        #expect(formatted([] as Set<Int>, format: format) == "")

        #expect(formatted(Set([1]), format: format) == "1")

        let a = formatted(Set([2, 1]), format: format)
        #expect(a == "1,2" || a == "2,1")
    }

    @Test
    func concreteType_customSeparator() throws {
        let format = SetToStringFormatStyle(of: Int.self, separator: "|", transform: .string)

        #expect(formatted([] as Set<Int>, format: format) == "")

        #expect(formatted(Set([1]), format: format) == "1")

        let a = formatted(Set([2, 1]), format: format)
        #expect(a == "1|2" || a == "2|1")
    }

    @Test
    func concreteStatic_defaultSeparator() throws {
        #expect(formatted([] as Set<Int>, format: Set<Int>.stringFormatStyle(transform: .string)) == "")

        #expect(formatted(Set([1]), format: Set<Int>.stringFormatStyle(transform: .string)) == "1")

        let a = formatted(Set([2, 1]), format: Set<Int>.stringFormatStyle(transform: .string))
        #expect(a == "1,2" || a == "2,1")
    }

    @Test
    func concreteStatic_customSeparator() throws {
        #expect(formatted([] as Set<Int>, format: Set<Int>.stringFormatStyle(separator: "|", transform: .string)) == "")

        #expect(formatted(Set([1]), format: Set<Int>.stringFormatStyle(separator: "|", transform: .string)) == "1")

        let a = formatted(Set([2, 1]), format: Set<Int>.stringFormatStyle(separator: "|", transform: .string))
        #expect(a == "1|2" || a == "2|1")
    }

    @Test
    func composition_separator() throws {
        #expect(formatted([] as Set<Int>, format: Set<Int>.stringFormatStyle(transform: .string).separator("|")) == "")

        #expect(formatted(Set([1]), format: Set<Int>.stringFormatStyle(transform: .string).separator("|")) == "1")

        let a = formatted(Set([2, 1]), format: Set<Int>.stringFormatStyle(transform: .string).separator("|"))
        #expect(a == "1|2" || a == "2|1")
    }
}
