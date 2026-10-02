//
//  ParseStrategyError.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Error returned by parse strategies provided by SwiftDataParsing.
public enum ParseStrategyError: Error {
    case parseError
}

extension ParseStrategyError: Equatable { }

extension ParseStrategyError: Hashable { }

extension ParseStrategyError: Sendable { }

extension ParseStrategyError {
    public var localizedDescription: String {
        switch self {
        case .parseError:
            "Error parsing value."
        }
    }
}
