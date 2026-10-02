//
//  StringToDoubleParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which converts a `String` value to a `Float` value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToDoubleParseStrategy {
    @inlinable
    nonisolated
    public init() { }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToDoubleParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToDoubleParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> Double {
        guard let double = Double(value) else {
            throw ParseStrategyError.parseError
        }
        return double
    }
}

// MARK: - `ParseStrategy` Static Constructor

extension ParseStrategy where Self == StringToDoubleParseStrategy {
    /// Parse strategy which converts a `String` value to a `Double` value.
    @inlinable
    nonisolated
    public static var double: Self {
        Self()
    }
}
