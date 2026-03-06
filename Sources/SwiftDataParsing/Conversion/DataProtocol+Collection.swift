//
//  DataProtocol+Collection.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import struct Foundation.Data
import protocol Foundation.DataProtocol

extension Collection<UInt8> {
    /// Returns a Data object using the array as bytes.
    /// Same as `Data(self)`.
    @_disfavoredOverload
    public func toData() -> Data {
        Data(self)
    }
}

extension DataProtocol {
    /// Returns an array of `UInt8` bytes.
    /// Same as `[UInt8](self)`
    @_disfavoredOverload
    public func toUInt8Bytes() -> [UInt8] {
        [UInt8](self)
    }
}

#endif
