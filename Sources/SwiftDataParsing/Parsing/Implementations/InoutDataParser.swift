//
//  InoutDataParser.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import protocol Foundation.DataProtocol

/// Utility to facilitate sequential reading of bytes.
/// Passing the data in as a mutable `inout` allows for passive memory reading. The data itself is never mutated.
///
/// > Note:
/// >
/// > This type is less performant than the inout/pointer-based data parsers, however the return types
/// > are fully copy-on-write compliant and are safe to use as-is after being passed out of the
/// >`withInoutDataParser { parser in }` closure.
///
/// > Note:
/// >
/// > This type is not meant to be initialized directly, but rather used within a call to `<data>.withInoutDataParser { parser in }`.
///
/// Usage with `Data`:
///
/// ```swift
/// let data = Data( ... )
/// try data.withInoutDataParser { parser in
///     let bytes = try parser.read(bytes: 4)
///     // ...
/// }
/// ```
///
/// Usage with `[UInt8]`:
///
/// ```swift
/// let bytes: [UInt8] = [ ... ]
/// try bytes.withInoutDataParser { parser in
///     let bytes = try parser.read(bytes: 4)
///     // ...
/// }
/// ```
public struct InoutDataParser<DataType: DataProtocol>: _DataReaderProtocol {
    public typealias DataElement = DataType.Element
    public typealias DataRange = DataType.SubSequence
    
    typealias DataAccess = (_ block: InoutDataAccess) -> Void
    typealias InoutDataAccess = (inout DataType) -> Void
    
    let dataAccess: DataAccess
    
    // MARK: - Init
    
    init(dataAccess: @escaping DataAccess) {
        self.dataAccess = dataAccess
    }
    
    // MARK: - State
    
    public internal(set) var readOffset = 0
    
    // MARK: - Internal
    
    @usableFromInline
    typealias DataIndex = DataType.Index
    
    @inlinable
    func _dataSize() -> Int {
        withData { $0.count }
    }
    
    @inlinable
    func _dataStartIndex() -> DataIndex {
        withData { $0.startIndex }
    }
    
    @inlinable
    func _dataReadOffsetIndex(offsetBy offset: Int) -> DataIndex {
        withData { $0.index($0.startIndex, offsetBy: readOffset + offset) }
    }
    
    @inlinable
    func _dataByte(at dataIndex: DataIndex) throws(DataParserError) -> DataElement {
        withData { $0[dataIndex] }
    }
    
    func _dataBytes(in dataIndexRange: Range<DataIndex>) throws(DataParserError) -> DataRange {
        withData { $0[dataIndexRange] }
    }
    
    func _dataBytes(in dataIndexRange: ClosedRange<DataIndex>) throws(DataParserError) -> DataRange {
        withData { $0[dataIndexRange] }
    }
    
    // MARK: - Helpers
    
    @inline(__always) @usableFromInline
    func withData<T>(_ block: (inout DataType) -> T) -> T {
        var out: T!
        dataAccess { out = block(&$0) }
        return out
    }
}

// MARK: - DataProtocol Extensions

// This generic implementation will work on any `DataProtocol`-conforming concrete type without needing
// individual implementations on the known concrete types.

extension DataProtocol {
    /// Accesses the data by providing an ``InoutDataParser`` instance to a closure.
    ///
    /// > Note:
    /// >
    /// > This type is less performant than the inout/pointer-based data parsers, however the return types
    /// > are fully copy-on-write compliant and are safe to use as-is after being passed out of the
    /// >`withInoutDataParser { parser in }` closure.
    @discardableResult
    public mutating func withInoutDataParser<T, E>(
        _ block: (_ parser: inout InoutDataParser<Self>) throws(E) -> T
    ) throws(E) -> T {
        // since `withUnsafe... { }` does not work with typed error throws, we have to use a workaround to get the typed error out
        var result: Result<T, E>!
        
        withUnsafeMutablePointer(to: &self) { ptr in
            var parser = InoutDataParser(dataAccess: { $0(&ptr.pointee) })
            do throws(E) {
                let value = try block(&parser)
                result = .success(value)
            } catch {
                result = .failure(error)
            }
        }
        return try result.get()
    }
}

// MARK: - API Changes from swift-extensions 2.0.0

@_documentation(visibility: internal)
@available(*, renamed: "InoutDataParser")
public typealias PassiveDataReader = InoutDataParser

extension PassiveDataReader {
    @_documentation(visibility: internal)
    @available(*, renamed: "DataType")
    public typealias D = DataType
    
    @_documentation(visibility: internal)
    @available(*, deprecated, message: "Data parsers are no longer instanced directly. Instead, call `data.withDataReader { parser in }`.")
    public init(_ closure: @escaping (_ block: (inout DataType) -> Void) -> Void) {
        self.dataAccess = closure
    }
    
    @_documentation(visibility: internal)
    @available(*, renamed: "DataParserError")
    public typealias ReadError = DataParserError
}

#endif
