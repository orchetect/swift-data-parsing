//
//  DataEndianness.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

// Endianness:
// All Apple platforms are currently little-endian
//
// Floating endianness:
// On some machines, while integers were represented in little-endian form, floating point numbers
// were represented in big-endian form. Because there are many floating point formats, and a lack of
// a standard "network" representation, no standard for transferring floating point values has been
// made. This means that floating point data written on one machine may not be readable on another,
// and this is the case even if both use IEEE 754 floating point arithmetic since the endianness of
// the memory representation is not part of the IEEE specification.

/// Enum describing binary storage endianness.
public enum DataEndianness {
    case littleEndian
    case bigEndian
}

extension DataEndianness: Equatable { }

extension DataEndianness: Hashable { }

extension DataEndianness: Sendable { }

// MARK: - API Changes from swift-extensions 2.0.0

@_documentation(visibility: internal)
@available(*, deprecated, renamed: "DataEndianness")
public typealias NumberEndianness = DataEndianness
