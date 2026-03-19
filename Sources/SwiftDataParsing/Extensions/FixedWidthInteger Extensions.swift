//
//  FixedWidthInteger Extensions.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension FixedWidthInteger {
    /// Returns a bit mask containing only the topmost (most significant) sign bit.
    public static var signBitMask: Self {
        0b1 << (bitWidth - 1)
    }
    
    /// Returns the topmost (most significant) sign bit.
    public var signBit: Self {
        (self & Self.signBitMask) >> (bitWidth - 1)
    }
    
    /// Returns a bit mask containing all but the topmost (most significant) sign bit.
    public static var nonSignBitsMask: Self {
        max >> 1
    }
    
    /// Returns the value masked by all but the topmost (most significant) sign bit.
    public var nonSignBits: Self {
        self & Self.nonSignBitsMask
    }
}
