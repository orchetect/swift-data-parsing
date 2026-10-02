//
//  ParseStrategy Test Utilities.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftDataParsing

/// Wrapper method to allow testing `ParseStrategy` static constructors.
func parsed<S: ParseStrategy>(_ value: S.ParseInput, strategy: S) throws -> S.ParseOutput {
    try strategy.parse(value)
}
