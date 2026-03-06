//
//  DataProtocol+String.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import struct Foundation.Data
import protocol Foundation.DataProtocol

extension String {
    /// Returns a Data representation of a String, defaulting to UTF-8 encoding.
    @_disfavoredOverload
    public func toData(using encoding: String.Encoding = .utf8) -> Data? {
        data(using: encoding)
    }
}

extension DataProtocol {
    /// Returns a String converted from Data. Optionally pass an encoding type.
    @_disfavoredOverload
    public func toString(using encoding: String.Encoding = .utf8) -> String? {
        String(data: Data(self), encoding: encoding)
    }
}

extension Data {
    /// Returns a String converted from Data. Optionally pass an encoding type.
    @_disfavoredOverload
    public func toString(using encoding: String.Encoding = .utf8) -> String? {
        String(data: self, encoding: encoding)
    }
}

#endif
