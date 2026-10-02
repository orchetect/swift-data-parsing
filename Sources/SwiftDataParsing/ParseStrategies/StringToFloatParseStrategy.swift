//
//  StringToFloatParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which converts a `String` value to a `Float` value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToFloatParseStrategy {
    @inlinable
    nonisolated
    public init() { }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToFloatParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToFloatParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> Float {
        guard let float = Float(value) else {
            throw ParseStrategyError.parseError
        }
        return float
    }
}

// MARK: - `ParseStrategy` Static Constructor

extension ParseStrategy where Self == StringToFloatParseStrategy {
    /// Parse strategy which converts a `String` value to a `Float` value.
    @inlinable
    nonisolated
    public static var float: Self {
        Self()
    }
}
