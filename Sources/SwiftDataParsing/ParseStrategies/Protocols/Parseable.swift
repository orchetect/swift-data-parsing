//
//  Parseable.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Implements a standard form of the `init(_:strategy:)` initializer to parse a value type using a `ParseStrategy`.
///  
/// This allows formatting custom types in a more Swift-friendly way by mimicking the data parsing paradigm
/// Foundation establishes when using `ParseStrategy`.
///
/// > Tip:
/// >
/// > Typically this paradigm is appropriate for value types representing fairly simple data structures.
/// > This paradigm is not intended for scenarios where a type is being decoded, in which case conforming
/// > to Swift's `Decodable` is more appropriate.
///
/// > Note:
/// >
/// > Some types in Foundation offer the same initializer, but most types do not. Conforming a type to this
/// > protocol adds the initializer to any type. It is recommended to only conform types you own, as standard
/// > types may gain this method in future updates of Swift.
/// >
/// > Types in Foundation that implement this initializer may not implement it exactly the same way.
/// > Some types use variations on the initializer that are bound to protocol-based generics instead of `Self`,
/// > or add additional parameters.
public protocol Parseable {
    /// Creates and initializes a new instance by parsing an arbitrary type according to the provided parse
    /// strategy.
    ///
    /// - Parameters:
    ///   - value: An instance of strategy’s input type.
    ///   - strategy: A parse strategy that describes how the parser converts the value to `Self`.
    init<S: ParseStrategy>(_ value: S.ParseInput, strategy: S) throws where S.ParseOutput == Self
}

// MARK: - Default Implementation

extension Parseable {
    public init<S: ParseStrategy>(_ value: S.ParseInput, strategy: S) throws where S.ParseOutput == Self {
        self = try strategy.parse(value)
    }
}

// MARK: - Standard Type Conformances

// Note: if any of the types below gain the same init in future releases of Swift, compilation will break

// `Int` and other `BinaryInteger` types already provide `formatted(_:)`

extension Array: Parseable { }
extension Set: Parseable { }
extension String: Parseable { }
