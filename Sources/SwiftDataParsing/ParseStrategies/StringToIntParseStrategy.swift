//
//  StringToIntParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which converts a `String` value to a fixed-width integer value.
/// This strategy is also capable of parsing floating-point numbers and booleans from strings.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToIntParseStrategy<T: FixedWidthInteger> {
    nonisolated
    public var options: Set<ParseOption>

    @inlinable
    nonisolated
    public init(options: Set<ParseOption> = []) {
        self.options = options
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToIntParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToIntParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> T {
        // first try T directly
        if let int = T(value) {
            return int
        }

        // parse floating-point numbers
        if let double = Double(value) {
            // respect option to only allow floats that are whole numbers (ie: 1.0, 2.0)
            if !options.contains(.allowNonWholeFloats) {
                guard double.integralAndFraction.fraction == 0.0 else {
                    throw ParseStrategyError.parseError
                }
            }
            return T(double)
        }

        // parse boolean strings
        if options.contains(.allowBool) {
            if let bool = try? StringToBoolParseStrategy().parse(value) {
                return bool ? 1 : 0
            }
        }

        throw ParseStrategyError.parseError
    }
}

// MARK: - ParseOption

extension StringToIntParseStrategy {
    public enum ParseOption: String, Equatable, Hashable, Sendable, Codable {
        /// Allow parsing strings that contain non-whole number floating-point values.
        case allowNonWholeFloats

        /// Allow parsing strings that are boolean values such as `true` or `false`.
        case allowBool
    }
}

// MARK: - Composition

extension StringToIntParseStrategy {
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

extension ParseStrategy where Self == StringToIntParseStrategy<Int> {
    /// Parse strategy which converts a `String` value to an `Int` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static var int: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to an `Int` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static func int(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}

extension ParseStrategy where Self == StringToIntParseStrategy<Int8> {
    /// Parse strategy which converts a `String` value to an `Int8` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static var int8: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to an `Int8` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static func int8(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}

extension ParseStrategy where Self == StringToIntParseStrategy<Int16> {
    /// Parse strategy which converts a `String` value to an `Int16` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static var int16: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to an `Int16` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static func int16(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}

extension ParseStrategy where Self == StringToIntParseStrategy<Int32> {
    /// Parse strategy which converts a `String` value to an `Int32` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static var int32: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to an `Int32` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static func int32(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}

extension ParseStrategy where Self == StringToIntParseStrategy<Int64> {
    /// Parse strategy which converts a `String` value to an `Int64` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static var int64: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to an `Int64` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static func int64(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}

extension ParseStrategy where Self == StringToIntParseStrategy<UInt> {
    /// Parse strategy which converts a `String` value to a `UInt` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static var uInt: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to a `UInt` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static func uInt(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}

extension ParseStrategy where Self == StringToIntParseStrategy<UInt8> {
    /// Parse strategy which converts a `String` value to a `UInt8` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static var uInt8: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to a `UInt8` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static func uInt8(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}

extension ParseStrategy where Self == StringToIntParseStrategy<UInt16> {
    /// Parse strategy which converts a `String` value to a `UInt16` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static var uInt16: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to a `UInt16` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static func uInt16(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}

extension ParseStrategy where Self == StringToIntParseStrategy<UInt32> {
    /// Parse strategy which converts a `String` value to a `UInt32` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static var uInt32: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to a `UInt32` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static func uInt32(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}

extension ParseStrategy where Self == StringToIntParseStrategy<UInt64> {
    /// Parse strategy which converts a `String` value to a `UInt64` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static var uInt64: Self {
        Self()
    }

    /// Parse strategy which converts a `String` value to a `UInt64` value.
    /// This strategy is also capable of parsing floating-point numbers and booleans from strings.
    @inlinable
    nonisolated
    public static func uInt64(options: Set<Self.ParseOption> = []) -> Self {
        Self(options: options)
    }
}
