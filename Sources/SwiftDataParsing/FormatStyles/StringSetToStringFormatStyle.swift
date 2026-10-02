//
//  StringSetToStringFormatStyle.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Format style which flattens a set of values to a delimited string.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringSetToStringFormatStyle<Comparator> where Comparator: SortComparator<String> & Codable {
    /// Element separator.
    nonisolated
    public var separator: String

    /// Element sort comparator.
    nonisolated
    public let sortComparator: Comparator?

    @inlinable
    nonisolated
    public init(separator: String = ",") where Comparator == String.Comparator {
        self.separator = separator
        sortComparator = nil
    }

    @inlinable
    nonisolated
    public init(separator: String = ",", sortComparator: Comparator) {
        self.separator = separator
        self.sortComparator = sortComparator
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringSetToStringFormatStyle: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringSetToStringFormatStyle: FormatStyle {
    nonisolated
    public func format(_ value: Set<String>) -> String {
        _sort(value)
            .joined(separator: separator)
    }

    nonisolated
    private func _sort(_ value: Set<String>) -> [String] {
        if let sortComparator {
            value.sorted(using: sortComparator)
        } else {
            Array(value)
        }
    }
}

// MARK: - Composition

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringSetToStringFormatStyle {
    /// Modifies a format style to use the specified element separator.
    @inlinable
    nonisolated
    public func separator(_ newSeparator: String) -> Self {
        var copy = self
        copy.separator = newSeparator
        return copy
    }

    /// Modifies a format style to use the specified element sort comparator.
    @inlinable
    nonisolated
    public func sortComparator<C>(_ newSortComparator: C) -> StringSetToStringFormatStyle<C> where C: SortComparator<String> & Codable {
        .init(separator: separator, sortComparator: newSortComparator)
    }
}

// MARK: - `FormatStyle` Static Constructors

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == StringSetToStringFormatStyle<String.Comparator> {
    /// Format style which flattens a set of values to a delimited string.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }

    /// Format style which flattens a set of values to a delimited string.
    @inlinable
    nonisolated
    public static func string(separator: String = ",") -> Self {
        Self(separator: separator)
    }

    /// Format style which flattens a set of values to a delimited string.
    @inlinable
    nonisolated
    public static func string(separator: String = ",", sortComparator: String.Comparator) -> Self {
        Self(separator: separator, sortComparator: sortComparator)
    }
}
