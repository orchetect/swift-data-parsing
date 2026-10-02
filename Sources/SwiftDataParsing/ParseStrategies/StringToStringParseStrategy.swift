//
//  StringToStringParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which validates a `String` value and subsequently returns it if the input value
/// passes validation, otherwise an error is thrown if validation does not pass.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToStringParseStrategy {
    /// Parse options.
    /// All input strings are considered valid unless one or more parse options are present.
    nonisolated
    public var options: Set<ParseOption>

    /// - Parameters:
    ///   - options: Parse options.
    ///     All input strings are considered valid unless one or more parse options are present.
    @inlinable
    nonisolated
    public init(options: Set<ParseOption> = []) {
        self.options = options
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToStringParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToStringParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> String {
        if options.contains(.rejectEmpty),
           value.isEmpty
        {
            throw ParseStrategyError.parseError
        }
        if options.contains(.rejectWhitespaceOnly),
           value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            throw ParseStrategyError.parseError
        }
        return value
    }
}

// MARK: - ParseOption

extension StringToStringParseStrategy {
    public enum ParseOption: String, Equatable, Hashable, Sendable, Codable {
        /// Reject empty strings.
        /// A string is considered empty if it contains zero characters.
        case rejectEmpty

        /// Reject strings that are entirely comprised of whitespaces.
        case rejectWhitespaceOnly
    }
}

// MARK: - Composition

extension StringToStringParseStrategy {
    /// Modifies a parse strategy to replace its parse options with the specified options.
    @inlinable
    nonisolated
    public func options(_ newOptions: Set<ParseOption>) -> Self {
        var copy = self
        copy.options = newOptions
        return copy
    }
}

// MARK: - `ParseStrategy` Static Constructors

extension ParseStrategy where Self == StringToStringParseStrategy {
    /// Parse strategy which validates a `String` value and subsequently returns it if the input value
    /// passes validation, otherwise an error is thrown if validation does not pass.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }

    /// Parse strategy which validates a `String` value and subsequently returns it if the input value
    /// passes validation, otherwise an error is thrown if validation does not pass.
    ///
    /// - Parameters:
    ///   - options: Parse options.
    ///     All input strings are considered valid unless one or more parse options are present.
    @inlinable
    nonisolated
    public static func string(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}
