//
//  ByteOrder+Static.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Darwin)

import var Foundation.NS_BigEndian
import var Foundation.NS_LittleEndian
import func Foundation.NSHostByteOrder

extension ByteOrder {
    private static func getByteOrder() -> ByteOrder {
        switch NSHostByteOrder() {
        case NS_BigEndian: .bigEndian
        case NS_LittleEndian: .littleEndian
        default: fatalError("Unknown system byte ordering.")
        }
    }
}

#elseif canImport(CoreFoundation)

import var CoreFoundation.CFByteOrderBigEndian
import func CoreFoundation.CFByteOrderGetCurrent
import var CoreFoundation.CFByteOrderLittleEndian

extension ByteOrder {
    private static func getByteOrder() -> ByteOrder {
        switch CFByteOrderGetCurrent() {
        case Int(CFByteOrderBigEndian.rawValue): .bigEndian
        case Int(CFByteOrderLittleEndian.rawValue): .littleEndian
        default: fatalError("Unknown system byte ordering.")
        }
    }
}

#else

extension ByteOrder {
    private static func getByteOrder() -> ByteOrder {
        fatalError("Unknown system byte ordering.")
    }
}

#endif

extension ByteOrder {
    /// Returns the current system hardware's byte order (endianness).
    @inline(__always)
    public static let platformDefault: ByteOrder = getByteOrder()
}
