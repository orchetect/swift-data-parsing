//
//  DataToStringFormatStyle.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Format style which converts a `Data` value to a `String` value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct DataToStringFormatStyle {
    /// String encoding format when converting data to a string.
    public var encoding: Encoding

    /// - Parameters:
    ///   - encoding: String encoding format when converting data to a string.
    @inlinable
    nonisolated
    public init(encoding: Encoding) {
        self.encoding = encoding
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension DataToStringFormatStyle: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension DataToStringFormatStyle: FormatStyle {
    nonisolated
    public func format(_ value: Data) -> String {
        switch encoding {
        case .base64:
            let encodedData = value.base64EncodedData()
            guard let string = String(data: encodedData, encoding: .utf8) else {
                assertionFailure("Failed to encode data as Base64 string.")
                return ""
            }
            return string
        }
    }
}

// MARK: - Encoding

extension DataToStringFormatStyle {
    public enum Encoding: String, Equatable, Hashable, Sendable, Codable, CaseIterable {
        /// Base64 encoding.
        case base64
    }
}

// MARK: - Composition

extension DataToStringFormatStyle {
    /// Modifies a format style to use the specified string encoding format.
    @inlinable
    nonisolated
    public func encoding(_ newEncoding: Self.Encoding) -> Self {
        var copy = self
        copy.encoding = newEncoding
        return copy
    }
}

// MARK: - `FormatStyle` Static Constructors

extension FormatStyle where Self == DataToStringFormatStyle {
    /// Format style which converts a `Data` value to a `String` value using Base64 encoding
    /// by default. The encoding can be changed by chaining this with the `encoding(_:)` method.
    @inlinable
    nonisolated
    public static var string: Self {
        Self(encoding: .base64)
    }

    /// Format style which converts a `Data` value to a `String` value.
    ///
    /// - Parameters:
    ///   - encoding: String encoding format when converting data to a string.
    @inlinable
    nonisolated
    public static func string(encoding: Self.Encoding) -> Self {
        Self(encoding: encoding)
    }
}
