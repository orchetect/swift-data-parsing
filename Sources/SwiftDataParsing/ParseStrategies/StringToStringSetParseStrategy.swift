//
//  StringToStringSetParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which parses a delimited a `String` value and produces a set of `String` values.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToStringSetParseStrategy {
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
extension StringToStringSetParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToStringSetParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> Set<String> {
        // note that `.components(separatedBy:)` returns `[""]` if the input is `""`,
        // but an empty array is more idiomatic, so handle the edge case first:
        guard !value.isEmpty else { return [] }

        let array = value
            .components(separatedBy: separator)
            .map { String($0) }

        return Set(array)
    }
}

// MARK: - Composition

extension StringToStringSetParseStrategy {
    /// Modifies a parse strategy to use the specified element separator.
    @inlinable
    nonisolated
    public func separator(_ newSeparator: String) -> Self {
        var copy = self
        copy.separator = newSeparator
        return copy
    }
}

// MARK: - `ParseStrategy` Static Constructors

extension ParseStrategy where Self == StringToStringSetParseStrategy {
    /// Parse strategy which parses a delimited a `String` value and produces a set of `String` values.
    @inlinable
    nonisolated
    public static var stringSet: Self {
        Self()
    }

    /// Parse strategy which parses a delimited a `String` value and produces a set of `String` values.
    @inlinable
    nonisolated
    public static func stringSet(separator: String = ",") -> Self {
        Self(separator: separator)
    }
}
