//
//  DataParserError.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Error returned by methods in ``DataReaderProtocol``-conforming types.
public enum DataParserError: Error {
    case pastEndOfStream
    case invalidByteCount
}

extension DataParserError: Equatable { }

extension DataParserError: Hashable { }

extension DataParserError: Sendable { }
