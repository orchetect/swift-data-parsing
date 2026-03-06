//
//  DataParserProtocol.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol

/// Protocol describing a common API layer for data reader implementations.
public protocol DataParserProtocol {
    associatedtype DataType: DataProtocol
    associatedtype DataRange
    associatedtype DataElement
    
    /// Current byte index of read offset (byte position).
    var readOffset: Int { get }
    
    /// Returns number of available remaining bytes.
    var remainingByteCount: Int { get }
    
    /// Manually advance by _n_ number of bytes from current read offset.
    /// Note that this method is unchecked which may result in an offset beyond the end of the data
    /// stream.
    mutating func advance(by count: Int)
    
    /// Return the next byte and optionally increment the read offset.
    ///
    /// If no bytes remain, an error will be returned.
    mutating func readByte(advance: Bool) throws(DataParserError) -> DataElement
    
    /// Return _n_ number of bytes and optionally increment the read offset.
    /// If `nil` byte count is passed, the remainder of the data will be returned.
    ///
    /// If fewer bytes remain than are requested, an error will be returned.
    mutating func read(bytes count: Int?, advance: Bool) throws(DataParserError) -> DataRange
    
    /// Resets read offset back to byte index 0.
    mutating func reset()
}

// MARK: - Defaulted Parameters Implementation
// Since protocols cannot define defaulted parameters of methods, we have to fake defaulted parameters with manual implementation.

extension DataParserProtocol {
    /// Return the next byte and increment the read offset.
    ///
    /// If no bytes remain, an error will be returned.
    public mutating func readByte() throws(DataParserError) -> DataElement {
        try readByte(advance: true)
    }
    
    /// Return the remainder of the data and increment the read offset.
    ///
    /// If fewer bytes remain than are requested, an error will be returned.
    public mutating func read() throws(DataParserError) -> DataRange {
        try read(bytes: nil, advance: true)
    }
    
    /// Return the remainder of the data, optionally incrementing the read offset.
    ///
    /// If fewer bytes remain than are requested, an error will be returned.
    public mutating func read(advance: Bool) throws(DataParserError) -> DataRange {
        try read(bytes: nil, advance: advance)
    }
    
    /// Return _n_ number of bytes and increment the read offset.
    /// If `nil` byte count is passed, the remainder of the data will be returned.
    ///
    /// If fewer bytes remain than are requested, an error will be returned.
    public mutating func read(bytes count: Int?) throws(DataParserError) -> DataRange {
        try read(bytes: count, advance: true)
    }
}

// MARK: - API Changes from swift-extensions 2.0.0

extension DataParserProtocol {
    @_documentation(visibility: internal)
    @available(*, renamed: "advance(by:)")
    public mutating func advanceBy(_ count: Int) {
        advance(by: count)
    }
    
    @_documentation(visibility: internal)
    @available(*, renamed: "readByte(advance:)")
    public mutating func nonAdvancingReadByte() throws(DataParserError) -> DataElement {
        try readByte(advance: false)
    }
    
    @_documentation(visibility: internal)
    @available(*, renamed: "read(advance:)")
    public mutating func nonAdvancingRead() throws(DataParserError) -> DataRange {
        try read(advance: false)
    }
    
    @_documentation(visibility: internal)
    @available(*, renamed: "read(bytes:advance:)")
    public mutating func nonAdvancingRead(bytes count: Int) throws(DataParserError) -> DataRange {
        try read(bytes: count, advance: false)
    }
}

#endif
