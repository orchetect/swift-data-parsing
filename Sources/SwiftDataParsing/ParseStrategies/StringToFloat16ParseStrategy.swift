//
//  StringToFloat16ParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which converts a `String` value to a `Float16` value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToFloat16ParseStrategy {
    @inlinable
    nonisolated
    public init() { }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToFloat16ParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToFloat16ParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> Float16 {
        guard let float = Float16(value) else {
            throw ParseStrategyError.parseError
        }
        return float
    }
}

// MARK: - `ParseStrategy` Static Constructor

extension ParseStrategy where Self == StringToFloat16ParseStrategy {
    /// Parse strategy which converts a `String` value to a `Float16` value.
    @inlinable
    nonisolated
    public static var float16: Self {
        Self()
    }
}
