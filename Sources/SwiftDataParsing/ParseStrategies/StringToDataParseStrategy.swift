//
//  StringToDataParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which converts an encoded `String` value to a `Data` value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToDataParseStrategy {
    /// String encoding format when converting a string to data.
    nonisolated
    public var encoding: Encoding

    /// - Parameters:
    ///   - encoding: String encoding format when converting a string to data.
    @inlinable
    nonisolated
    public init(encoding: Encoding) {
        self.encoding = encoding
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToDataParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToDataParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> Data {
        switch encoding {
        case .base64:
            guard let rawData = value.data(using: .utf8) else {
                throw ParseStrategyError.parseError
            }
            guard let decodedData = Data(base64Encoded: rawData) else {
                throw ParseStrategyError.parseError
            }
            return decodedData
        }
    }
}

// MARK: - Encoding

extension StringToDataParseStrategy {
    public enum Encoding: String, Equatable, Hashable, Sendable, Codable, CaseIterable {
        /// Base64 encoding.
        case base64
    }
}

// MARK: - Composition

extension StringToDataParseStrategy {
    /// Modifies a parse strategy to use the specified string encoding format.
    @inlinable
    nonisolated
    public func encoding(_ newEncoding: Self.Encoding) -> Self {
        var copy = self
        copy.encoding = newEncoding
        return copy
    }
}

// MARK: - `ParseStrategy` Static Constructors

extension ParseStrategy where Self == StringToDataParseStrategy {
    /// Parse strategy which converts an encoded `String` value to a `Data` value using Base64 encoding
    /// by default. The encoding can be changed by chaining this with the `encoding(_:)` method.
    @inlinable
    nonisolated
    public static var data: Self {
        Self(encoding: .base64)
    }

    /// Parse strategy which converts an encoded `String` value to a `Data` value.
    ///
    /// - Parameters:
    ///   - encoding: String encoding format when converting a string to data.
    @inlinable
    nonisolated
    public static func data(encoding: Self.Encoding) -> Self {
        Self(encoding: encoding)
    }
}
