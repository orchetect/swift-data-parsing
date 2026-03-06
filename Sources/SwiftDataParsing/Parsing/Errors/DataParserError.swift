//
//  DataParserError.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Error returned by methods in ``DataParserProtocol``-conforming types.
public enum DataParserError: Error {
    case invalidByteCount
    case pastStartOfStream
    case pastEndOfStream
}

extension DataParserError: Equatable { }

extension DataParserError: Hashable { }

extension DataParserError: Sendable { }
