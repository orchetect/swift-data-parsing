//
//  DataProtocol+Int.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol

// MARK: - UInt

extension DataProtocol {
    /// Returns a UInt value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toUInt(from endianness: DataEndianness = .platformDefault) -> UInt? {
        toNumber(from: endianness, toType: UInt.self)
    }
}

// MARK: - UInt8

extension DataProtocol {
    /// Returns a UInt8 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toUInt8() -> UInt8? {
        guard count == 1 else { return nil }
        return first
    }
}

// MARK: - UInt16

extension DataProtocol {
    /// Returns a UInt16 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toUInt16(from endianness: DataEndianness = .platformDefault) -> UInt16? {
        toNumber(from: endianness, toType: UInt16.self)
    }
}

// MARK: - UInt32

extension DataProtocol {
    /// Returns a UInt32 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toUInt32(from endianness: DataEndianness = .platformDefault) -> UInt32? {
        toNumber(from: endianness, toType: UInt32.self)
    }
}

// MARK: - UInt64

extension DataProtocol {
    /// Returns a UInt64 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toUInt64(from endianness: DataEndianness = .platformDefault) -> UInt64? {
        toNumber(from: endianness, toType: UInt64.self)
    }
}

// MARK: - UInt128

// TODO: Add UInt128 on supported platforms

#endif
