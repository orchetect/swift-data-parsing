//
//  StringToBoolParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which converts a `String` value to a `Bool` value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToBoolParseStrategy {
    nonisolated
    public var options: Set<ParseOption>

    @inlinable
    nonisolated
    public init(options: Set<ParseOption> = []) {
        self.options = options
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToBoolParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToBoolParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> Bool {
        let casedValue = (options.contains(.caseInsensitive) ? value.lowercased() : value)

        switch casedValue {
        case "true", "TRUE", "t", "T", "yes", "YES", "y", "Y":
            return true

        case "false", "FALSE", "f", "F", "no", "NO", "n", "N":
            return false

        default:
            // check for exact 0 or 1 (either integer or floating-point)
            if let number = Int(value), number == 0 || number == 1 {
                return number > 0
            } else if let number = Double(value), number == 0.0 || number == 1.0 {
                return number.isFinite && (number > 0.0)
            }

            // check be an out-of-bounds number if option is specified
            if options.contains(.allowOutOfBoundsNumbers) {
                if let number = Int(value) {
                    return number > 0
                } else if let number = Double(value) {
                    return number.isFinite && (number > 0.0)
                }
            }

            throw ParseStrategyError.parseError
        }
    }
}

// MARK: - ParseOption

extension StringToBoolParseStrategy {
    public enum ParseOption: String, Equatable, Hashable, Sendable, Codable {
        /// String comparison is case-insensitive.
        case caseInsensitive

        /// When parsing numerical representations of a boolean (ie: `0` or `1`),
        /// allow out-of-bounds numbers to resolve to the most appropriate boolean
        /// representation. When this option is not present, out-of-bounds numbers
        /// result in an error being thrown.
        case allowOutOfBoundsNumbers
    }
}

// MARK: - Composition

extension StringToBoolParseStrategy {
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

extension ParseStrategy where Self == StringToBoolParseStrategy {
    /// Parse strategy which converts a `String` value to a `Bool` value.
    @inlinable
    nonisolated
    public static var bool: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to a `Bool` value.
    @inlinable
    nonisolated
    public static func bool(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}
