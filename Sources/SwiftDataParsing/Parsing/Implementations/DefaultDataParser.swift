//
//  DefaultDataParser.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import struct Foundation.Data
import protocol Foundation.DataProtocol

/// Alias to the most performant binary data parser for the current platform.
public typealias DefaultDataParser = PointerDataParser

// MARK: - DataProtocol Extensions

extension DataProtocol {
    /// Utility to facilitate sequential reading of bytes using the most performant binary data parser for the current platform.
    @_disfavoredOverload @discardableResult
    public func withDataParser<T, E>(
        _ block: (_ parser: inout DefaultDataParser<Self>) throws(E) -> T
    ) throws(E) -> T {
        try withPointerDataParser(block)
    }
}

#endif
