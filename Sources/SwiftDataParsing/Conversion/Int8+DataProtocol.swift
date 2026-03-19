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
    public func toData(as encoding: SignedIntegerEncoding = .signedBit) -> Data {
        let byte = UInt8(decoding: self, as: encoding)
        return Data([byte])
    }
}

#endif
