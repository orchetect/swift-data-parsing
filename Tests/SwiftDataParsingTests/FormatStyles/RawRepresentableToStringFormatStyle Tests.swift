//
//  RawRepresentableToStringFormatStyle Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftDataParsing

/// This suite tests:
/// - `RawRepresentableToStringFormatStyle` static constructors
/// - Basic string formatting results
@Suite
struct RawRepresentableToStringFormatStyle_Tests {
    /// Tests using the `<TYPE>.rawValueFormatStyle` static constructor
    @Test
    func rawRepresentableExtension() throws {
        #expect(formatted(MyEnum.foo, format: MyEnum.rawValueFormatStyle) == "foo")
        #expect(formatted(MyEnum.bar, format: MyEnum.rawValueFormatStyle) == "bar")
    }
}

// MARK: - Test Types

private enum MyEnum: String {
    case foo
    case bar
}
