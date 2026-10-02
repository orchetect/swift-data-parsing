//
//  BoolToStringFormatStyle.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Format style which converts a `Bool` value to a `String` value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct BoolToStringFormatStyle {
    @inlinable
    nonisolated
    public init() { }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension BoolToStringFormatStyle: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension BoolToStringFormatStyle: FormatStyle {
    nonisolated
    public func format(_ value: Bool) -> String {
        // String interpolation of a Bool (ie: "\(bool)") should always produce English words,
        // but just to be sure, we will use explicit strings to ensure encoding is always
        // consistent across all locales and system languages.
        value ? "true" : "false"
    }
}

// MARK: - `FormatStyle` Static Constructor

extension FormatStyle where Self == BoolToStringFormatStyle {
    /// Format style which converts a `Bool` value to a `String` value.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}
