# swift-data-parsing

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Forchetect%2Fswift-data-parsing%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/orchetect/swift-data-parsing) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Forchetect%swift-data-parsing%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/orchetect/swift-data-parsing) [![Xcode 16](https://img.shields.io/badge/Xcode-16-blue.svg?style=flat)](https://developer.apple.com/swift) [![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/orchetect/swift-data-parsing/blob/main/LICENSE)

Multi-platform Swift binary data parsing abstractions, with integer and floating-point conversions to/from binary data with control over byte endianness.

## Summary

### Data Parsing

Simple and performant binary data parsing abstractions can be used to sequentially parse arbitrary binary data.

Read methods advance the offset position by default, but can be performed as read-ahead operations by supplying `false` to the `advance` parameter.

Read methods throwing if not enough byte are available:

```swift
let data = Data([0x01, 0x02, 0x03, 0x04, 0x05])

try data.withDataParser { parser in
    let a = try parser.readByte(advance: false) // 0x01 as UInt8
    let b = try parser.read(bytes: 2, advance: false) // [0x01, 0x02] as UInt8 buffer ptr
    let c = try parser.read(advance: false) // [0x01, 0x02, 0x03, 0x04, 0x05] as UInt8 buffer ptr
}
```

Methods to read bytes and advance the offset position, throwing if not enough byte are available:

```swift
let data = Data([0x01, 0x02, 0x03, 0x04, 0x05])

try data.withDataParser { parser in
    let a = try parser.readByte() // 0x01 as UInt8
    let b = try parser.read(bytes: 2) // [0x02, 0x03] as UInt8 buffer ptr
    let c = try parser.read(bytes: 2) // [0x04, 0x05] as UInt8 buffer ptr
    let d = try parser.readByte() // throws error; not enough bytes
}

try data.withDataParser { parser in
    let a = try parser.readByte() // 0x01 as UInt8
    let b = try parser.read() // [0x02, 0x03, 0x04, 0x05] as UInt8 buffer ptr
	let c = try parser.readByte() // throws error; not enough bytes
}

try data.withDataParser { parser in
    try parser.seek(by: 4) // advance offset without reading the bytes
    try parser.seek(by: -3) // recede offset without reading the bytes
    let a = try parser.readByte() // 0x02 as UInt8
}

try data.withDataParser { parser in
    try parser.seek(to: 3) // set the absolute read offset
    let a = try parser.readByte() // 0x04 as UInt8
    
    parser.seek(unsafeTo: 100) // set the absolute read offset without bounds checking
    let b = try parser.readByte() // throws error; past end of data
}

try data.withDataParser { parser in
    _ = parser.readOffset // 0
    _ = parser.remainingByteCount // 5
}
```

Byte ranges can be subscripted, compared, and more:

```swift
let data = Data([0x01, 0x02, 0x03, 0x04, 0x05])

try data.withDataParser { parser in
    let byte = try parser.readByte() // 0x01 as UInt8
    let bytes = try parser.read(bytes: 2) // [0x02, 0x03] as UInt8 buffer ptr
    
    // byte ranges can be subscripted using indexes rebased to 0
    let byte1 = bytes[0] // 0x02 as UInt8
    let byte2 = bytes[1] // 0x03 as UInt8
    
    // byte ranges can be tested for equality against other data
    // (Data, UInt8 array, UInt8 ptr, etc.)
    if bytes == [0x02, 0x03] { }
    if bytes == Data([0x02, 0x03]) { }
}
```

The parser can return a value:

```swift
let data = Data([0x04, 0x44, 0x41, 0x54, 0x41])

let value: String? = try data.withDataParser { parser in
    let length = try parser.readByte() // 0x04 as UInt8
    let chars = try parser.read(bytes: Int(length)) // 4 bytes as UInt8 buffer ptr
    let string = String(bytes: chars, encoding: .utf8)
    return string
}

print(value) // Optional("DATA")
```

### Numeric Conversion

Numeric types (integers and floating-point) can be easily converted from binary bytes.

```swift
// Data -> Int
Data([0x01]).toInt8() // 1 as Int8?
Data([0x01, 0x00]).toInt16() // 1 as Int16?
Data([0x01, 0x00, 0x00, 0x00]).toInt32() // 1 as Int32?
Data([0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]).toInt64() // 1 as Int64?
Data([0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]).toInt() // 1 as Int?

// Data -> UInt
Data([0x01]).toUInt8() // 1 as UInt8?
Data([0x01, 0x00]).toUInt16() // 1 as UInt16?
Data([0x01, 0x00, 0x00, 0x00]).toUInt32() // 1 as UInt32?
Data([0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]).toUInt64() // 1 as UInt64?
Data([0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]).toUInt() // 1 as UInt?

// Data -> Floating-Point
Data([0x00, 0x00, 0x80, 0x3F]).toFloat32() // 1.0 as Float32?
Data([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0x3F]).toDouble() // 1.0 as Double?
```

Conversely, the same numeric types can be converted to binary bytes.

```swift
Int16(1).toData() // Data([0x01, 0x00])?
// etc.
```

By default, platform-default endianness is assumed, but source endianness can be specified when converting to/from binary data that needs specific byte ordering.

```swift
Data([0x01, 0x00]).toUInt16() // 1 as UInt16? // (Apple platforms use litte-endian)
Data([0x01, 0x00]).toUInt16(from: .littleEndian) // 1 as UInt16?
Data([0x00, 0x01]).toUInt16(from: .bigEndian) // 1 as UInt16?

UInt16(1).toData() // Data([0x01, 0x00])? // (Apple platforms use litte-endian)
UInt16(1).toData(.littleEndian) // Data([0x01, 0x00])?
UInt16(1).toData(.bigEndian) // Data([0x00, 0x01])?
```

### Data Conversion

Various types of binary data can be converted to one another using extension methods.

```swift
// Data -> [UInt8]
let data = Data([0x01, 0x02])
let bytes = data.toUInt8Bytes() // as [UInt8]

// [UInt8] -> Data
let bytes: [UInt8] = [0x01, 0x02]
let data = bytes.toData() // as Data
```

## Installation: Swift Package Manager (SPM)

### Dependency within an Application Project

1. Add the package to your Xcode project using Swift Package Manager using `https://github.com/orchetect/swift-data-parsing` as the URL.

2. Import the module where needed.

   ```swift
   import SwiftDataParsing
   ```

### Dependency within a Swift Package

In your Package.swift file:

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/orchetect/swift-data-parsing", from: "0.1.0")
    ],
    targets: [
        .target(
            dependencies: [
                .product(name: "SwiftDataParsing", package: "swift-data-parsing")
            ]
        )
    ]
)
```

## Extending the Library

In addition to the data parsers provided by the library, it is possible to define custom parsing implementation by adopting the `DataParserProtocol` protocol.

This is a basic template to get started:

<details>
<summary>Show Code</summary>

```swift
public struct CustomDataParser<DataType: DataProtocol & Sendable>: DataParserProtocol {
    public typealias DataElement = DataType.Element
    public typealias DataRange = DataType.SubSequence
    
    let data: DataType
    
    public internal(set) var readOffset: Int = 0
    
    init(data: DataType) {
        self.data = data
        count = data.count
    }
    
    @inline(__always)
    public let count: Int
    
    @inline(__always)
    public mutating func seek(unsafeTo offset: Int) {
        readOffset = offset
    }
    
    public mutating func readByte(advance: Bool) throws(DataParserError) -> DataElement {
        guard remainingByteCount > 0 else { throw .pastEndOfStream }
        let byte = data[data.index(data.startIndex, offsetBy: readOffset)]
        if advance { readOffset += 1 }
        return byte
    }
    
    public mutating func read(bytes count: Int?, advance: Bool) throws(DataParserError) -> DataRange {
        let count = count ?? remainingByteCount
        guard count > -1 else { throw .invalidByteCount }
        guard count <= remainingByteCount else { throw .pastEndOfStream }
        let startIndex = data.index(data.startIndex, offsetBy: readOffset)
        let endIndex = data.index(startIndex, offsetBy: count)
        if advance { readOffset += count }
        let data = data[startIndex ..< endIndex]
        return data
    }
}

extension DataProtocol {
    @discardableResult
    public func withCustomDataParser<T, E>(
        _ block: (_ parser: inout CustomDataParser<Self>) throws(E) -> T
    ) throws(E) -> T {
        var parser = CustomDataParser(data: self)
        return try block(&parser)
    }
}
```

</details>

## Documentation

Most methods are implemented as category methods so they are generally discoverable.

All methods are documented with inline help explaining their purpose and basic usage examples.

## Author

Coded by a bunch of 🐹 hamsters in a trenchcoat that calls itself [@orchetect](https://github.com/orchetect).

## License

Licensed under the MIT license. See [LICENSE](https://github.com/orchetect/swift-data-parsing/blob/master/LICENSE) for details.

## Sponsoring

If you enjoy using swift-data-parsing and want to contribute to open-source financially, GitHub sponsorship is much appreciated. Feedback and code contributions are also welcome.

## Community & Support

Please do not email maintainers for technical support. Several options are available for issues and questions:

- Questions and feature ideas can be posted to [Discussions](https://github.com/orchetect/swift-data-parsing/discussions).
- If an issue is a verifiable bug with reproducible steps it may be posted in [Issues](https://github.com/orchetect/swift-data-parsing/issues).

## Contributions

Contributions are welcome. Posting in [Discussions](https://github.com/orchetect/swift-data-parsing/discussions) first prior to new submitting PRs for features or modifications is encouraged.

## Legacy

This repository was extracted from swift-extensions 2.0.0 into its own repository in March of 2026.
