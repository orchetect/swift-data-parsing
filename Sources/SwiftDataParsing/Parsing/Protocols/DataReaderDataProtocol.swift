//
//  DataReaderDataProtocol.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)

import struct Foundation.Data
import protocol Foundation.DataProtocol

/// Protocol adopted by data types supported by ``DataReaderProtocol``.
protocol DataReaderDataProtocol where Self: DataProtocol, SubSequence: DataReaderDataProtocol {
    associatedtype SubSequence
    
    // Restated from DataProtocol concrete types
    func withUnsafeBytes<ResultType>(_ body: (UnsafeRawBufferPointer) throws -> ResultType) rethrows -> ResultType
}

// MARK: - Concrete Type Conformances

extension Data: DataReaderDataProtocol { }
// extension Data.SubSequence: DataReaderDataProtocol { } // not needed since Data.SubSequence == Data

extension [UInt8]: DataReaderDataProtocol { }
extension [UInt8].SubSequence /* aka ArraySlice<UInt8> */: DataReaderDataProtocol { }

extension UnsafeBufferPointer<UInt8>: DataReaderDataProtocol { }
extension UnsafeBufferPointer<UInt8>.SubSequence /* aka Slice<UnsafeBufferPointer<UInt8>> */: DataReaderDataProtocol { }

#endif
