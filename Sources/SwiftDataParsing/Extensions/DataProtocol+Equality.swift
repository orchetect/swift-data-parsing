//
//  DataProtocol+Equality.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import struct Foundation.Data
import protocol Foundation.DataProtocol

// These built-in types conform to `DataProtocol` (but not limited to):
// - Data
// - [UInt8]
// - [UInt8].SubSequence (aka ArraySlice<UInt8>)
// - UnsafeBufferPointer<UInt8>
// - UnsafeBufferPointer<UInt8>.SubSequence (aka Slice<UnsafeBufferPointer<UInt8>>)

// Note that adding `@_disfavoredOverload` to any of these methods causes some implementations
// to fail, as some underlying methods does not function as expected.

// While this works in place of all of the individual methods below, it may be a bit heavy handed.
// extension DataProtocol {
//     public static func == (lhs: Self, rhs: some DataProtocol) -> Bool {
//         lhs.elementsEqual(rhs)
//     }
// }

extension DataProtocol {
    public static func == (lhs: Self, rhs: Data) -> Bool {
        lhs.elementsEqual(rhs)
    }
    
    public static func == (lhs: Self, rhs: [UInt8]) -> Bool {
        lhs.elementsEqual(rhs)
    }
    
    public static func == (lhs: Self, rhs: ArraySlice<UInt8>) -> Bool {
        lhs.elementsEqual(rhs)
    }
    
    public static func == (lhs: Self, rhs: UnsafeBufferPointer<UInt8>) -> Bool {
        lhs.elementsEqual(rhs)
    }
    
    public static func == (lhs: Self, rhs: Slice<UnsafeBufferPointer<UInt8>>) -> Bool {
        lhs.elementsEqual(rhs)
    }
}

#endif
