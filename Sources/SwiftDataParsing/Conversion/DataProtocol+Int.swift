//
//  DataProtocol+Int.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol
import struct Foundation.Data

// MARK: - Int

extension DataProtocol {
    /// Returns an `Int` value from `Data`.
    /// Returns `nil` if Data is not the correct length.
    @_disfavoredOverload
    public func toInt(
        from byteOrder: ByteOrder = .platformDefault,
        as encoding: SignedIntegerEncoding = .signedBit
    ) -> Int? {
        toNumber(from: byteOrder, toType: Int.self, as: encoding)
    }
}

// MARK: - Int8

extension DataProtocol {
    /// Returns an `Int8` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toInt8(as encoding: SignedIntegerEncoding = .signedBit) -> Int8? {
        guard count == 1 else {
            assertionFailure("Data byte length is incorrect. Expected 1 byte but got \(count).")
            return nil
        }
        
        var byte = UInt8()
        withUnsafeMutableBytes(of: &byte) {
            _ = self.copyBytes(to: $0, count: 1)
        }
        
        return Int8(decoding: byte, as: encoding)
    }
}

// MARK: - Int16

extension DataProtocol {
    /// Returns an `Int16` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toInt16(
        from byteOrder: ByteOrder = .platformDefault,
        as encoding: SignedIntegerEncoding = .signedBit
    ) -> Int16? {
        toNumber(from: byteOrder, toType: Int16.self, as: encoding)
    }
}

// MARK: - Int32

extension DataProtocol {
    /// Returns an `Int32` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toInt32(
        from byteOrder: ByteOrder = .platformDefault,
        as encoding: SignedIntegerEncoding = .signedBit
    ) -> Int32? {
        toNumber(from: byteOrder, toType: Int32.self, as: encoding)
    }
}

// MARK: - Int64

extension DataProtocol {
    /// Returns an `Int64` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toInt64(
        from byteOrder: ByteOrder = .platformDefault,
        as encoding: SignedIntegerEncoding = .signedBit
    ) -> Int64? {
        toNumber(from: byteOrder, toType: Int64.self, as: encoding)
    }
}

// MARK: - Int128

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension DataProtocol {
    /// Returns an `Int128` value from `Data`.
    /// Returns `nil` if `self` is not the correct length.
    @_disfavoredOverload
    public func toInt128(
        from byteOrder: ByteOrder = .platformDefault,
        as encoding: SignedIntegerEncoding = .signedBit
    ) -> Int128? {
        toNumber(from: byteOrder, toType: Int128.self, as: encoding)
    }
}

#endif
