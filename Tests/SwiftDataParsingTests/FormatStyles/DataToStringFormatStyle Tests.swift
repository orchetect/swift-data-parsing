//
//  DataToStringFormatStyle Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftDataParsing

/// This suite tests:
/// - `DataToStringFormatStyle`:
///   - Static constructors
///   - Composition methods
///   - All `Encoding` encodings
/// - Basic string formatting results
@Suite
struct DataToStringFormatStyle_Tests {
    @Test
    func concreteType_defaultEncoding() throws {
        // default uses Base64
        let format = DataToStringFormatStyle.string

        #expect(format.format(Data()) == "")
        #expect(format.format(Data([0x01, 0x02])) == "AQI=")
    }

    @Test
    func staticConstructor_defaultEncoding() throws {
        // default uses Base64
        #expect(formatted(Data(), format: .string) == "")
        #expect(formatted(Data([0x01, 0x02]), format: .string) == "AQI=")
    }

    @Test
    func composition_encoding() throws {
        #expect(formatted(Data(), format: .string.encoding(.base64)) == "")
        #expect(formatted(Data([0x01, 0x02]), format: .string.encoding(.base64)) == "AQI=")
    }

    @Test(arguments: DataToStringFormatStyle.Encoding.allCases)
    func allEncodings_constructors(encoding: DataToStringFormatStyle.Encoding) throws {
        switch encoding {
        case .base64:
            // struct init
            #expect(DataToStringFormatStyle(encoding: encoding).encoding == encoding)
            // composition method
            #expect(DataToStringFormatStyle.string.encoding(encoding).encoding == encoding)
        }
    }

    @Test(arguments: DataToStringFormatStyle.Encoding.allCases)
    func allEncodings_format(encoding: DataToStringFormatStyle.Encoding) throws {
        // use a switch case on allCases for compiler enforcement of testing all encodings
        switch encoding {
        case .base64:
            let format = DataToStringFormatStyle(encoding: encoding)
            #expect(format.format(Data()) == "")
            #expect(format.format(Data([0x01, 0x02])) == "AQI=")
        }
    }
}
