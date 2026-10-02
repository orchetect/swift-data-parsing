//
//  FormatStyle Test Utilities.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftDataParsing

/// Wrapper method to allow testing `FormatStyle` static constructors.
func formatted<S: FormatStyle>(_ value: S.FormatInput, format: S) -> S.FormatOutput {
    format.format(value)
}
