//
//  Formattable Tests.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftDataParsing

@Suite
struct Formattable_Tests {
    // MARK: - Built-In Behavior

    // Check behavior of `formatted(_:)` where implemented on Swift/Foundation's built-in types
    // there are other relevant standard types, but testing all of them is not necessary.
    // this test is just a form of a staging area to establish or check behaviors.

    @Test
    func builtIn_Decimal() throws {
        #expect(
            Decimal(1.23)
                .formatted(.percent.locale(.init(identifier: "en-US")))
            == "123%"
        )
    }

    @Test
    func builtIn_String() throws {
        #expect("foo".formatted(.string) == "foo")
    }

    @Test
    func builtIn_Array() throws {
        #expect(
            [1, 2]
                .formatted(
                    .list(memberStyle: .string, type: .and)
                    .locale(.init(identifier: "en-US"))
                )
            == "1 and 2"
        )
    }

    @Test
    func builtIn_Set() throws {
        let formattedSet = Set([1, 2])
            .formatted(
                .list(memberStyle: .string, type: .and)
                .locale(.init(identifier: "en-US"))
            )
        #expect(formattedSet == "1 and 2" || formattedSet == "2 and 1")
    }

    // MARK: - Standard Type Conformances

    // @Test
    // func formattable_<#TYPE#>() throws {
    //
    // }
}
