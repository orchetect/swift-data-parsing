//
//  DefaultDataReader.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import struct Foundation.Data
import protocol Foundation.DataProtocol

/// Alias to the most performant binary data parser for the current platform.
public typealias DefaultDataReader = PointerDataParser

// MARK: - DataReader Extensions

extension DataProtocol {
    /// Utility to facilitate sequential reading of bytes using the most performant binary data parser for the current platform.
    @_disfavoredOverload @discardableResult
    public func withDataReader<T, E>(
        _ block: (_ parser: inout DefaultDataReader<Self>) throws(E) -> T
    ) throws(E) -> T {
        try withPointerDataParser(block)
    }
}

#endif
