//
//  StringToStringArrayParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which parses a delimited a `String` value and produces an array of `String` values.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToStringArrayParseStrategy {
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
extension StringToStringArrayParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToStringArrayParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> [String] {
        // note that `.components(separatedBy:)` returns `[""]` if the input is `""`,
        // but an empty array is more idiomatic, so handle the edge case first:
        guard !value.isEmpty else { return [] }

        return value
            .components(separatedBy: separator)
            .map { String($0) }
    }
}

// MARK: - Composition

extension StringToStringArrayParseStrategy {
    /// Modifies a parse strategy to use the specified element separator.
    @inlinable
    nonisolated
    public func separator(_ separator: String) -> Self {
        var copy = self
        copy.separator = separator
        return copy
    }
}

// MARK: - `ParseStrategy` Static Constructors

extension ParseStrategy where Self == StringToStringArrayParseStrategy {
    /// Parse strategy which parses a delimited a `String` value and produces an array of `String` values.
    @inlinable
    nonisolated
    public static var stringArray: Self {
        Self()
    }

    /// Parse strategy which parses a delimited a `String` value and produces an array of `String` values.
    @inlinable
    nonisolated
    public static func stringArray(separator: String = ",") -> Self {
        Self(separator: separator)
    }
}
