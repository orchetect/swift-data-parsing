//
//  Int8+DataProtocol.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol
import struct Foundation.Data

extension Int8 {
    /// Returns `Data` representation of a signed integer.
    @_disfavoredOverload
    public func toData(_ encoding: SignedIntegerEncoding = .signedBit) -> Data {
        let byte = UInt8(self, encoding: encoding)
        return Data([byte])
    }
}

#endif
