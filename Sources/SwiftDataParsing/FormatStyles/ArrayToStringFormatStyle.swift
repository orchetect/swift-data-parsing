//
//  ArrayToStringFormatStyle.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Format style which flattens an array of values to a delimited string.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct ArrayToStringFormatStyle<Element, Transform>
where Transform: FormatStyle & Sendable, Transform.FormatInput == Element, Transform.FormatOutput == String
{
    /// Element separator.
    nonisolated
    public var separator: String

    /// Element format style to use when mapping array elements to strings.
    nonisolated
    public var transform: Transform

    @inlinable
    nonisolated
    public init(of elementType: Element.Type = Element.self, separator: String = ",", transform: Transform) {
        self.separator = separator
        self.transform = transform
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension ArrayToStringFormatStyle: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension ArrayToStringFormatStyle: FormatStyle {
    nonisolated
    public func format(_ value: [Element]) -> String {
        value
            .map { transform.format($0) }
            .joined(separator: separator)
    }
}

// MARK: - Composition

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension ArrayToStringFormatStyle {
    /// Modifies a format style to use the specified element separator.
    @inlinable
    nonisolated
    public func separator(_ newSeparator: String) -> Self {
        var copy = self
        copy.separator = newSeparator
        return copy
    }

    /// Modifies a format style to use the specified element transform.
    @inlinable
    nonisolated
    public func transform<T>(
        _ newTransform: T
    ) -> ArrayToStringFormatStyle<Element, T>
    where T: FormatStyle & Sendable, T.FormatInput == Element, T.FormatOutput == String
    {
        .init(separator: separator, transform: newTransform)
    }
}

// MARK: - `FormatStyle` Static Constructor

// Note that due to associated generics of the array's Element, there is no feasible way to offer
// a standard static constructor extension on `FormatStyle`, as there is no way to express the constraints.
// @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
// extension FormatStyle { }

// MARK: - `Array` Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension Array {
    // This constructor must include the Array metatype as the base when called.
    // For example:
    //     let string = String([1, 2, 3], format: [Int].stringFormatStyle(transform: .string))

    /// Format style which flattens an array of values to a delimited string.
    @inlinable
    nonisolated
    public static func stringFormatStyle<Transform>(
        separator: String = ",",
        transform: Transform
    ) -> ArrayToStringFormatStyle<Element, Transform>
    where Transform: FormatStyle & Sendable, Transform.FormatInput == Element, Transform.FormatOutput == String
    {
        ArrayToStringFormatStyle(separator: separator, transform: transform)
    }
}
