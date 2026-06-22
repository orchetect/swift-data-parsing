//
//  UnsignedInteger Extensions.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension UnsignedInteger {
    /// Access binary bits, zero-based from least significant to most significant.
    @inlinable @_disfavoredOverload
    public func bit(_ position: Int) -> Self {
        (self & (0b1 << position)) >> position
    }
}
