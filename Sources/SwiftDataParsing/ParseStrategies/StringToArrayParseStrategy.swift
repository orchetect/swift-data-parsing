//
//  StringToArrayParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which parses a delimited a `String` value and produces an array of values.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToArrayParseStrategy<Element, Transform>
where Transform: ParseStrategy & Sendable, Transform.ParseInput == String, Transform.ParseOutput == Element
{
    /// Element separator.
    nonisolated
    public var separator: String

    /// Element parse strategy to use when mapping parsed array string elements.
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
extension StringToArrayParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToArrayParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> [Element] {
        // note that `.components(separatedBy:)` returns `[""]` if the input is `""`,
        // but an empty array is more idiomatic, so handle the edge case first:
        guard !value.isEmpty else { return [] }

        return try value
            .components(separatedBy: separator)
            .map { try transform.parse($0) }
    }
}

// MARK: - Composition

extension StringToArrayParseStrategy {
    /// Modifies a parse strategy to use the specified element separator.
    @inlinable
    nonisolated
    public func separator(_ newSeparator: String) -> Self {
        var copy = self
        copy.separator = newSeparator
        return copy
    }

    /// Modifies a parse strategy to use the specified element transform.
    @inlinable
    nonisolated
    public func transform<T>(
        _ newTransform: T
    ) -> StringToSetParseStrategy<Element, T>
    where T: ParseStrategy & Sendable, T.ParseInput == String, T.ParseOutput == Element
    {
        .init(separator: separator, transform: newTransform)
    }
}

// MARK: - `ParseStrategy` Static Constructor

// Note that due to associated generics of the array's Element, there is no feasible way to offer
// a standard static constructor extension on `ParseStrategy`, as there is no way to express the constraints.
// @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
// extension ParseStrategy { }

// MARK: - `Array` Static Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension Array {
    // This constructor must include the Array metatype as the base when called.
    // For example:
    //     let intArray = [Int]("1,2,3", strategy: [Int].stringParseStrategy(transform: .int))

    /// Parse strategy which parses a delimited a `String` value and produces an array of values.
    @inlinable
    nonisolated
    public static func stringParseStrategy<Transform>(
        separator: String = ",",
        transform: Transform
    ) -> StringToArrayParseStrategy<Element, Transform>
    where Transform: ParseStrategy & Sendable, Transform.ParseInput == String, Transform.ParseOutput == Element
    {
        StringToArrayParseStrategy(separator: separator, transform: transform)
    }
}
