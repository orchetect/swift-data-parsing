//
//  PointerDataParser.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import struct Foundation.Data
import protocol Foundation.DataProtocol

/// Utility to facilitate sequential reading of bytes.
///
/// > Warning: Do not pass pointers returned from parser methods outside of the `withPointerDataParser { parser in }` closure.
/// >
/// > Any data needed to be passed outside of the closure must be copied first.
/// >
/// > This can be done by constructing a `Data(pointer)` or `[UInt8](pointer)` instance from the `pointer`.
///
/// > Note:
/// >
/// > This type is not meant to be initialized directly, but rather used within a call to `<data>.withPointerDataParser { parser in }`.
///
/// Usage with `Data`:
///
/// ```swift
/// let data = Data( ... )
/// try data.withPointerDataParser { parser in
///     let bytes = try parser.read(bytes: 4)
///     // ...
/// }
/// ```
///
/// Usage with `[UInt8]`:
///
/// ```swift
/// let bytes: [UInt8] = [ ... ]
/// try bytes.withPointerDataParser { parser in
///     let bytes = try parser.read(bytes: 4)
///     // ...
/// }
/// ```
public struct PointerDataParser<DataType: DataProtocol>: _DataParserProtocol {
    public typealias DataElement = DataType.Element
    public typealias DataRange = UnsafeBufferPointer<UInt8>
    
    @usableFromInline
    let pointer: UnsafeBufferPointer<UInt8>
    
    // MARK: - Init
    
    init(pointer: UnsafeBufferPointer<UInt8>) {
        self.pointer = pointer
    }
    
    // MARK: - State
    
    public internal(set) var readOffset = 0
    
    // MARK: - Internal
    
    @usableFromInline
    typealias DataIndex = Int
    
    func _dataSize() -> Int {
        pointer.count
    }
    
    @inlinable
    func _dataStartIndex() -> DataIndex {
        pointer.startIndex
    }
    
    @inlinable
    func _dataReadOffsetIndex(offsetBy offset: Int) -> DataIndex {
        pointer.indices.lowerBound.advanced(by: readOffset + offset)
    }
    
    @inlinable
    func _dataByte(at dataIndex: DataIndex) throws(DataParserError) -> DataElement {
        pointer[dataIndex]
    }
    
    func _dataBytes(in dataIndexRange: Range<DataIndex>) throws(DataParserError) -> DataRange {
        pointer.extracting(dataIndexRange)
    }
    
    func _dataBytes(in dataIndexRange: ClosedRange<DataIndex>) throws(DataParserError) -> DataRange {
        pointer.extracting(dataIndexRange)
    }
}

// MARK: - DataProtocol Extensions

extension DataProtocol {
    /// Accesses the data by way of unsafe pointer access by providing a ``PointerDataParser`` instance to a closure.
    ///
    /// > Warning: Do not pass pointers returned from parser methods outside of the `withPointerDataParser { parser in }` closure.
    /// >
    /// > Any data needed to be passed outside of the closure must be copied first.
    /// >
    /// > This can be done by constructing a `Data(pointer)` or `[UInt8](pointer)` instance from the `pointer`.
    @discardableResult
    public func withPointerDataParser<T, E>(
        _ block: (_ parser: inout PointerDataParser<Self>) throws(E) -> T
    ) throws(E) -> T {
        // since `withUnsafe... { }` does not work with typed error throws, we have to use a workaround to get the typed error out
        var result: Result<T, E>!
        
        // Knowledge of the underlying concrete data type is necessary to ensure correct pointer access.
        if let self = self as? any DataParserDataProtocol {
            self.withUnsafeBytes { ptr in
                let boundPtr = ptr.assumingMemoryBound(to: UInt8.self)
                var parser = PointerDataParser<Self>(pointer: boundPtr)
                do throws(E) {
                    let value = try block(&parser)
                    result = .success(value)
                } catch {
                    result = .failure(error)
                }
            }
        } else {
            if withContiguousStorageIfAvailable({ ptr in
                var parser = PointerDataParser<Self>(pointer: ptr)
                do throws(E) {
                    let value = try block(&parser)
                    result = .success(value)
                } catch {
                    result = .failure(error)
                }
            }) as Void? == nil {
                // TODO: this is not tested and may not work with unhandled concrete DataProtocol types
                withUnsafeBytes(of: self) { ptr in
                    let boundPtr = ptr.assumingMemoryBound(to: UInt8.self)
                    var parser = PointerDataParser<Self>(pointer: boundPtr)
                    do throws(E) {
                        let value = try block(&parser)
                        result = .success(value)
                    } catch {
                        result = .failure(error)
                    }
                }
            }
        }
        return try result.get()
    }
}

#endif
