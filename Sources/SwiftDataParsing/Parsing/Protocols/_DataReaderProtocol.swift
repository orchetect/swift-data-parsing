//
//  _DataReaderProtocol.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol

/// Internal members of ``DataReaderProtocol``.
protocol _DataReaderProtocol: DataReaderProtocol {
    associatedtype DataIndex: Comparable
    
    /// Current byte offset.
    var readOffset: Int { get set }
    
    /// Return the byte count of the data structure.
    func _dataSize() -> Int
    
    /// Return the data structure start index.
    func _dataStartIndex() -> DataIndex
    
    /// Return the data structure index that corresponds to the current user-facing ``readOffset`` value,
    /// optionally offset by a byte distance.
    func _dataReadOffsetIndex(offsetBy offset: Int) -> DataIndex
    
    /// Return the data byte at the given data structure index.
    func _dataByte(at dataIndex: DataIndex) throws(DataParserError) -> DataElement
    
    /// Return the data bytes in the given data structure index range.
    func _dataBytes(in dataIndexRange: Range<DataIndex>) throws(DataParserError) -> DataRange
    
    /// Return the data bytes in the given data structure index range.
    func _dataBytes(in dataIndexRange: ClosedRange<DataIndex>) throws(DataParserError) -> DataRange
}

// MARK: - Public Implementation

extension _DataReaderProtocol {
    public var remainingByteCount: Int { _dataSize() - readOffset }
    
    public mutating func advance(by count: Int) {
        readOffset += count
    }
    
    public mutating func readByte(advance: Bool) throws(DataParserError) -> DataElement {
        let d = try dataByte()
        defer { if advance { readOffset += 1 } }
        return d
    }
    
    public mutating func read(bytes count: Int?, advance: Bool) throws(DataParserError) -> DataRange {
        let d = try data(bytes: count)
        defer { if advance { readOffset += d.advanceCount } }
        return d.data
    }
    
    public mutating func reset() {
        readOffset = 0
    }
}

// MARK: - Internal Helpers

extension _DataReaderProtocol {
    func dataByte() throws(DataParserError) -> DataElement {
        guard remainingByteCount > 0 else { throw .pastEndOfStream }
        let readPosIndex = _dataReadOffsetIndex(offsetBy: 0)
        return try _dataByte(at: readPosIndex)
    }
    
    func data(bytes count: Int? = nil) throws(DataParserError) -> (data: DataRange, advanceCount: Int) {
        if count == 0 {
            // return empty bytes, but as a SubSequence
            let index = _dataReadOffsetIndex(offsetBy: 0)
            let bytes = try _dataBytes(in: index ..< index)
            return (data: bytes, advanceCount: 0)
        }
        
        if let count,
           count < 0 { throw .invalidByteCount }
        
        let readPosStartIndex = _dataReadOffsetIndex(offsetBy: 0)
        
        let remainingCount = remainingByteCount
        
        let count = count ?? remainingCount
        
        guard count <= remainingCount else {
            throw .pastEndOfStream
        }
        
        let endIndex = _dataReadOffsetIndex(offsetBy: count - 1)
        
        let returnBytes = try _dataBytes(in: readPosStartIndex ... endIndex)
        
        return (data: returnBytes, advanceCount: count)
    }
}

#endif
