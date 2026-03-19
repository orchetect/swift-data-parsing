//
//  DecodableFromSignedInteger.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

public protocol DecodableFromSignedInteger where Self: UnsignedInteger {
    associatedtype DecodedInteger: SignedInteger & FixedWidthInteger
    init(bitPattern x: DecodedInteger)
}

extension UInt: DecodableFromSignedInteger {
    public typealias DecodedInteger = Int
}

extension UInt8: DecodableFromSignedInteger {
    public typealias DecodedInteger = Int8
}

extension UInt16: DecodableFromSignedInteger {
    public typealias DecodedInteger = Int16
}

extension UInt32: DecodableFromSignedInteger {
    public typealias DecodedInteger = Int32
}

extension UInt64: DecodableFromSignedInteger {
    public typealias DecodedInteger = Int64
}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension UInt128: DecodableFromSignedInteger {
    public typealias DecodedInteger = Int128
}
