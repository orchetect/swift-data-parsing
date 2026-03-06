//
//  CopyingDataParser.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import struct Foundation.Data
import protocol Foundation.DataProtocol

/// Utility to facilitate sequential reading of bytes.
///
/// > Note:
/// >
/// > This type is less performant than the inout/pointer-based data parsers, however the return types
/// > are fully copy-on-write compliant and are safe to use as-is after being passed out of the
/// > `withCopyingDataParser { parser in }` closure.
///
/// > Note:
/// >
/// > This type is not meant to be initialized directly, but rather used within a call to `<data>.withPointerDataParser { parser in }`.
///
/// Usage with `Data`:
///
/// ```swift
/// let data = Data( ... )
/// try data.withCopyingDataParser { parser in
///     let bytes = try parser.read(bytes: 4)
///     // ...
/// }
/// ```
///
/// Usage with `[UInt8]`:
///
/// ```swift
/// let bytes: [UInt8] = [ ... ]
/// try bytes.withCopyingDataParser { parser in
///     let bytes = try parser.read(bytes: 4)
///     // ...
/// }
/// ```
public struct CopyingDataParser<DataType: DataProtocol & Sendable>: _DataReaderProtocol {
    public typealias DataElement = DataType.Element
    public typealias DataRange = DataType.SubSequence

    @usableFromInline
    let base: DataType

    init(data: DataType) {
        base = data
    }

    // MARK: - State

    public internal(set) var readOffset = 0

    // MARK: - Internal

    @usableFromInline
    typealias DataIndex = DataType.Index
    
    @inlinable
    func _dataSize() -> Int {
        base.count
    }

    @inlinable
    func _dataStartIndex() -> DataIndex {
        base.startIndex
    }

    @inlinable
    func _dataReadOffsetIndex(offsetBy offset: Int) -> DataIndex {
        base.index(base.startIndex, offsetBy: readOffset + offset)
    }

    @inlinable
    func _dataByte(at dataIndex: DataIndex) throws(DataParserError) -> DataElement {
        base[dataIndex]
    }

    func _dataBytes(in dataIndexRange: Range<DataIndex>) throws(DataParserError) -> DataRange {
        base[dataIndexRange]
    }

    func _dataBytes(in dataIndexRange: ClosedRange<DataIndex>) throws(DataParserError) -> DataRange {
        base[dataIndexRange]
    }
}

extension CopyingDataParser: Sendable { }

// MARK: - DataProtocol Extensions

// This generic implementation will work on any `DataProtocol`-conforming concrete type without needing
// individual implementations on the known concrete types.

extension DataProtocol {
    /// Accesses the data by providing a ``CopyingDataParser`` instance to a closure.
    ///
    /// > Note:
    /// >
    /// > This type is less performant than the inout/pointer-based data parsers, however the return types
    /// > are fully copy-on-write compliant and are safe to use as-is after being passed out of the
    /// > `withCopyingDataParser { parser in }` closure.
    @discardableResult
    public func withCopyingDataParser<T, E>(
        _ block: (_ parser: inout CopyingDataParser<Self>) throws(E) -> T
    ) throws(E) -> T {
        var parser = CopyingDataParser(data: self)
        return try block(&parser)
    }
}

// MARK: - API Changes from swift-extensions 2.0.0

@_documentation(visibility: internal)
@available(*, renamed: "CopyingDataParser")
public typealias DataReader = CopyingDataParser

extension DataReader where DataType == Data {
    @_documentation(visibility: internal)
    @available(*, deprecated, message: "Data parsers are no longer instanced directly. Instead, call `data.withDataParser { parser in }`.")
    public init(_ data: Data) {
        self.init(data: data)
    }
}

#endif
