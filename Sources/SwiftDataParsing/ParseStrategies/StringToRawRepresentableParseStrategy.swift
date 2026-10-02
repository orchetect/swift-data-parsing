//
//  StringToRawRepresentableParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which converts a `String` value to a `RawRepresentable` value whose raw value is `String`.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToRawRepresentableParseStrategy<ParseOutput> where ParseOutput: RawRepresentable, ParseOutput.RawValue == String {
    @inlinable
    nonisolated
    public init() { }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToRawRepresentableParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToRawRepresentableParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> ParseOutput {
        guard let instance = ParseOutput(rawValue: value) else {
            throw ParseStrategyError.parseError
        }
        return instance
    }
}

// MARK: - `ParseStrategy` Static Constructors

// Note that due to associated generics of the `RawRepresentable` type, there is no feasible way to offer
// a standard static constructor extension on `ParseStrategy`, as there is no way to express the constraints.
// @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
// extension ParseStrategy { }

// MARK: - `RawRepresentable` Static Constructor

extension RawRepresentable where RawValue == String {
    // This constructor must include the RawRepresentable metatype as the base when called.
    // For example:
    //     let myEnum = MyEnum("foo", strategy: MyEnum.rawValueParseStrategy)

    /// Parse strategy which converts a `String` value to a `RawRepresentable` value whose raw value is `String`.
    @inlinable
    nonisolated
    public static var rawValueParseStrategy: StringToRawRepresentableParseStrategy<Self> {
        StringToRawRepresentableParseStrategy()
    }
}
