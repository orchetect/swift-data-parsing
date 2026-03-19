//
//  SignedIntegerEncoding.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Signed integer data/memory storage encoding format (bit ordering).
public enum SignedIntegerEncoding {
    /// Signed bit. (Default)
    /// Possible value range is `-128 ... 127`.
    case signedBit
    
    /// One's complement.
    /// Possible value range is `-127 ... 127` including both negative and positive zeros (`-0` and `+0`).
    case onesComplement
    
    /// Two's complement.
    /// Possible value range is `-128 ... 127`.
    case twosComplement
}

extension SignedIntegerEncoding: Equatable { }

extension SignedIntegerEncoding: Hashable { }

extension SignedIntegerEncoding: Sendable { }
