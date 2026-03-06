//
//  DataEndianness+Static.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(CoreFoundation)

import var CoreFoundation.CFByteOrderBigEndian
import func CoreFoundation.CFByteOrderGetCurrent

extension DataEndianness {
    /// Returns the current system hardware's byte order endianness.
    @inline(__always)
    public static let platformDefault: DataEndianness =
        CFByteOrderGetCurrent() == CFByteOrderBigEndian.rawValue
            ? .bigEndian
            : .littleEndian
}

#endif
