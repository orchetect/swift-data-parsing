//
//  StringArrayToStringFormatStyle.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Format style which flattens an array of values to a delimited string.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringArrayToStringFormatStyle {
    /// Element separator.
    nonisolated
    public var separator: String

    @inlinable
    nonisolated
    public init(separator: String = ",") {
        self.separator = separator
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringArrayToStringFormatStyle: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringArrayToStringFormatStyle: FormatStyle {
    nonisolated
    public func format(_ value: [String]) -> String {
        value
            .joined(separator: separator)
    }
}

// MARK: - Composition

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringArrayToStringFormatStyle {
    /// Modifies a format style to use the specified element separator.
    @inlinable
    nonisolated
    public func separator(_ newSeparator: String) -> Self {
        var copy = self
        copy.separator = newSeparator
        return copy
    }
}

// MARK: - `FormatStyle` Static Constructors

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == StringArrayToStringFormatStyle {
    /// Format style which flattens an array of values to a delimited string.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }

    /// Format style which flattens an array of values to a delimited string.
    @inlinable
    nonisolated
    public static func string(separator: String = ",") -> Self {
        Self(separator: separator)
    }
}
