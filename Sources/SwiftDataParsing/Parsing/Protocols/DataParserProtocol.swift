//
//  DataParserProtocol.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol

/// Protocol describing a common API layer for binary data parser implementations.
public protocol DataParserProtocol {
    associatedtype DataType: DataProtocol
    associatedtype DataRange
    associatedtype DataElement
    
    /// Current byte index of read offset (byte position).
    var readOffset: Int { get }
    
    /// Returns number of available remaining bytes.
    var remainingByteCount: Int { get }
    
    /// Advance (positive integer) or recede (negative integer) by the specified number of bytes from current read offset.
    ///
    /// If the resulting read offset is past the start or past one-past-the-end, an error is thrown.
    mutating func seek(by delta: Int) throws(DataParserError)
    
    /// Return the next byte and optionally increment the read offset.
    ///
    /// If no bytes remain, an error will be thrown.
    mutating func readByte(advance: Bool) throws(DataParserError) -> DataElement
    
    /// Return _n_ number of bytes and optionally increment the read offset.
    /// If `nil` byte count is passed, the remainder of the data will be returned.
    ///
    /// If fewer bytes remain than are requested, an error will be thrown.
    mutating func read(bytes count: Int?, advance: Bool) throws(DataParserError) -> DataRange
    
    /// Resets read offset back to byte index 0.
    mutating func reset()
}

// MARK: - Defaulted Parameters Implementation
// Since protocols cannot define defaulted parameters of methods, we have to fake defaulted parameters with manual implementation.

extension DataParserProtocol {
    /// Return the next byte and increment the read offset.
    ///
    /// If no bytes remain, an error will be thrown.
    public mutating func readByte() throws(DataParserError) -> DataElement {
        try readByte(advance: true)
    }
    
    /// Return the remainder of the data and increment the read offset.
    ///
    /// If fewer bytes remain than are requested, an error will be thrown.
    public mutating func read() throws(DataParserError) -> DataRange {
        try read(bytes: nil, advance: true)
    }
    
    /// Return the remainder of the data, optionally incrementing the read offset.
    ///
    /// If fewer bytes remain than are requested, an error will be thrown.
    public mutating func read(advance: Bool) throws(DataParserError) -> DataRange {
        try read(bytes: nil, advance: advance)
    }
    
    /// Return _n_ number of bytes and increment the read offset.
    /// If `nil` byte count is passed, the remainder of the data will be returned.
    ///
    /// If fewer bytes remain than are requested, an error will be thrown.
    public mutating func read(bytes count: Int?) throws(DataParserError) -> DataRange {
        try read(bytes: count, advance: true)
    }
}

#endif
