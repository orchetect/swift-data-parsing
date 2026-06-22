//
//  DataProtocol+UInt.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol

// MARK: - UInt

extension DataProtocol {
    /// Returns a `UInt` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toUInt(from byteOrder: ByteOrder = .platformDefault) -> UInt? {
        toNumber(from: byteOrder, toType: UInt.self)
    }
}

// MARK: - UInt8

extension DataProtocol {
    /// Returns a `UInt8` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toUInt8() -> UInt8? {
        guard count == 1 else {
            assertionFailure("Data byte length is incorrect. Expected 1 byte but got \(count).")
            return nil
        }
        return first
    }
}

// MARK: - UInt16

extension DataProtocol {
    /// Returns a `UInt16` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toUInt16(from byteOrder: ByteOrder = .platformDefault) -> UInt16? {
        toNumber(from: byteOrder, toType: UInt16.self)
    }
}

// MARK: - UInt32

extension DataProtocol {
    /// Returns a `UInt32` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toUInt32(from byteOrder: ByteOrder = .platformDefault) -> UInt32? {
        toNumber(from: byteOrder, toType: UInt32.self)
    }
}

// MARK: - UInt64

extension DataProtocol {
    /// Returns a `UInt64` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toUInt64(from byteOrder: ByteOrder = .platformDefault) -> UInt64? {
        toNumber(from: byteOrder, toType: UInt64.self)
    }
}

// MARK: - UInt128

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension DataProtocol {
    /// Returns a `UInt128` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toUInt128(from byteOrder: ByteOrder = .platformDefault) -> UInt128? {
        toNumber(from: byteOrder, toType: UInt128.self)
    }
}

#endif
