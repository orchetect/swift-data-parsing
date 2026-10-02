//
//  IntToStringFormatStyle.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Format style which converts a binary integer value to a `String` value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct IntToStringFormatStyle<T: BinaryInteger> {
    @inlinable
    nonisolated
    public init() { }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension IntToStringFormatStyle: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension IntToStringFormatStyle: FormatStyle {
    nonisolated
    public func format(_ value: T) -> String {
        "\(value)"
    }
}

// MARK: - `FormatStyle` Static Constructors

extension FormatStyle where Self == IntToStringFormatStyle<Int> {
    /// Format style which converts an `Int` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}

extension FormatStyle where Self == IntToStringFormatStyle<Int8> {
    /// Format style which converts an `Int8` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}

extension FormatStyle where Self == IntToStringFormatStyle<Int16> {
    /// Format style which converts an `Int16` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}

extension FormatStyle where Self == IntToStringFormatStyle<Int32> {
    /// Format style which converts an `Int32` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}

extension FormatStyle where Self == IntToStringFormatStyle<Int64> {
    /// Format style which converts an `Int64` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}

extension FormatStyle where Self == IntToStringFormatStyle<UInt> {
    /// Format style which converts a `UInt` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}

extension FormatStyle where Self == IntToStringFormatStyle<UInt8> {
    /// Format style which converts a `UInt8` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}

extension FormatStyle where Self == IntToStringFormatStyle<UInt16> {
    /// Format style which converts a `UInt16` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}

extension FormatStyle where Self == IntToStringFormatStyle<UInt32> {
    /// Format style which converts a `UInt32` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}

extension FormatStyle where Self == IntToStringFormatStyle<UInt64> {
    /// Format style which converts a `UInt64` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}
