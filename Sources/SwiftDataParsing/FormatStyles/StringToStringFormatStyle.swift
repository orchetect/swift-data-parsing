//
//  StringToStringFormatStyle.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Format style which acts as a no-op, passings its input directly to its output.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToStringFormatStyle {
    @inlinable
    nonisolated
    public init() { }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToStringFormatStyle: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToStringFormatStyle: FormatStyle {
    @inlinable
    nonisolated
    public func format(_ value: String) -> String {
        value
    }
}

// MARK: - `FormatStyle` Static Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == StringToStringFormatStyle {
    /// Format style which acts as a no-op, passings its input directly to its output.
    @inlinable
    nonisolated
    public static var string: Self {
        Self()
    }
}
