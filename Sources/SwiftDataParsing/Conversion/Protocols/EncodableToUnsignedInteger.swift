//
//  EncodableToUnsignedInteger.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

public protocol EncodableToUnsignedInteger where Self: SignedInteger {
    associatedtype EncodedInteger: UnsignedInteger & FixedWidthInteger
    init(bitPattern x: EncodedInteger)
}

extension Int: EncodableToUnsignedInteger {
    public typealias EncodedInteger = UInt
}

extension Int8: EncodableToUnsignedInteger {
    public typealias EncodedInteger = UInt8
}

extension Int16: EncodableToUnsignedInteger {
    public typealias EncodedInteger = UInt16
}

extension Int32: EncodableToUnsignedInteger {
    public typealias EncodedInteger = UInt32
}

extension Int64: EncodableToUnsignedInteger {
    public typealias EncodedInteger = UInt64
}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension Int128: EncodableToUnsignedInteger {
    public typealias EncodedInteger = UInt128
}
