//
//  RawRepresentableToStringFormatStyle.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Format style which converts a `RawRepresentable` value whose raw value is `String` to its raw value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct RawRepresentableToStringFormatStyle<FormatInput> where FormatInput: RawRepresentable, FormatInput.RawValue == String {
    @inlinable
    nonisolated
    public init() { }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension RawRepresentableToStringFormatStyle: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension RawRepresentableToStringFormatStyle: FormatStyle {
    nonisolated
    public func format(_ value: FormatInput) -> String {
        value.rawValue
    }
}

// MARK: - `FormatStyle` Static Constructor

// Note that due to associated generics of the `RawRepresentable` type, there is no feasible way to offer
// a standard static constructor extension on `FormatStyle`, as there is no way to express the constraints.
// @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
// extension FormatStyle { }

// MARK: - `RawRepresentable` Static Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension RawRepresentable where RawValue == String {
    // This constructor must include the RawRepresentable metatype as the base when called.
    // For example:
    //     let string = String(MyEnum.foo, format: MyEnum.rawValueFormatStyle)

    /// Format style which converts a `RawRepresentable` value whose raw value is `String` to its raw value.
    @inlinable
    nonisolated
    public static var rawValueFormatStyle: RawRepresentableToStringFormatStyle<Self> {
        RawRepresentableToStringFormatStyle()
    }
}
