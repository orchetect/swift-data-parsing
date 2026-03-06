//
//  DataProtocol+Int.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol

// MARK: - Int

extension DataProtocol {
    /// Returns an Int64 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt(from endianness: DataEndianness = .platformDefault) -> Int? {
        toNumber(from: endianness, toType: Int.self)
    }
}

// MARK: - Int8

extension DataProtocol {
    /// Returns a Int8 value from Data (stored as two's complement).
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt8() -> Int8? {
        guard count == 1 else { return nil }
        
        var int = UInt8()
        withUnsafeMutableBytes(of: &int) {
            _ = self.copyBytes(to: $0, count: 1)
        }
        return Int8(bitPattern: int)
    }
}

// MARK: - Int16

extension DataProtocol {
    /// Returns an Int16 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt16(from endianness: DataEndianness = .platformDefault) -> Int16? {
        toNumber(from: endianness, toType: Int16.self)
    }
}

// MARK: - Int32

extension DataProtocol {
    /// Returns an Int32 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt32(from endianness: DataEndianness = .platformDefault) -> Int32? {
        toNumber(from: endianness, toType: Int32.self)
    }
}

// MARK: - Int64

extension DataProtocol {
    /// Returns an Int64 value from Data.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt64(from endianness: DataEndianness = .platformDefault) -> Int64? {
        toNumber(from: endianness, toType: Int64.self)
    }
}

// MARK: - Int128

// TODO: Add Int128 on supported platforms

#endif
