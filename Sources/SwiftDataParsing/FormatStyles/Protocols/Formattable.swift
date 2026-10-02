//
//  Formattable.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Implements a standard form of the `formatted(_:)` method to format a type using a `FormatStyle`.
///
/// This allows formatting custom types in a more Swift-friendly way by mimicking the data formatting paradigm
/// Foundation establishes when using `FormatStyle`.
///
/// > Tip:
/// >
/// > Typically this paradigm is appropriate for value types representing fairly simple data structures.
/// > This paradigm is not intended for scenarios where a type is being encoded, in which case conforming
/// > to Swift's `Encodable` is more appropriate.
///
/// > Note:
/// >
/// > Some types in Foundation offer the same method, but most types do not. Conforming a type to this protocol
/// > adds the method to any type. It is recommended to only conform types you own, as standard types may gain
/// > this method in future updates of Swift.
/// >
/// > Types in Foundation that implement this method may not implement it exactly the same way.
/// > Some types use variations on the method that are bound to protocol-based generics instead of `Self`,
/// > or add additional parameters.
public protocol Formattable {
    /// Formats the instance using the provided format style.
    ///
    /// - Parameters:
    ///   - format: The format style to apply when formatting the instance.
    func formatted<S: FormatStyle>(_ format: S) -> S.FormatOutput where S.FormatInput == Self
}

// MARK: - Default Implementation

extension Formattable {
    public func formatted<S: FormatStyle>(_ format: S) -> S.FormatOutput where S.FormatInput == Self {
        format.format(self)
    }
}

// MARK: - Standard Type Conformances

// Note: if any of the types below gain the same method in future releases of Swift, compilation will break

// `String` already provides `formatted(_:)`
// `Array` already provides `formatted(_:)`
// `Set` already provides `formatted(_:)`
