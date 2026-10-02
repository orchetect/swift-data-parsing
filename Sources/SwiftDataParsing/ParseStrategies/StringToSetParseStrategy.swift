//
//  StringToSetParseStrategy.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Parse strategy which parses a delimited a `String` value and produces a set of values.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct StringToSetParseStrategy<Element, Transform>
where Element: Hashable,
      Transform: ParseStrategy & Sendable, Transform.ParseInput == String, Transform.ParseOutput == Element
{
    /// Element separator.
    nonisolated
    public var separator: String

    /// Element parse strategy to use when mapping parsed set string elements.
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
extension StringToSetParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringToSetParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> Set<Element> {
        // note that `.components(separatedBy:)` returns `[""]` if the input is `""`,
        // but an empty array is more idiomatic, so handle the edge case first:
        guard !value.isEmpty else { return [] }

        let array = try value
            .components(separatedBy: separator)
            .map { try transform.parse($0) }
        return Set(array)
    }
}

// MARK: - Composition

extension StringToSetParseStrategy {
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

// Note that due to associated generics of the set's Element, there is no feasible way to offer
// a standard static constructor extension on `ParseStrategy`, as there is no way to express the constraints.
// @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
// extension ParseStrategy { }

// MARK: - `Set` Static Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension Set {
    // This constructor must include the Set metatype as the base when called.
    // For example:
    //     let intSet = Set<Int>("1,2,3", strategy: Set<Int>.stringFormatStyle(transform: .int))

    /// Parse strategy which parses a delimited a `String` value and produces a set of values.
    @inlinable
    nonisolated
    public static func stringParseStrategy<Transform>(
        separator: String = ",",
        transform: Transform
    ) -> StringToSetParseStrategy<Element, Transform>
    where Transform: ParseStrategy & Sendable, Transform.ParseInput == String, Transform.ParseOutput == Element
    {
        StringToSetParseStrategy(separator: separator, transform: transform)
    }
}
