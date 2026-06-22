//
//  DataProtocol+Double.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation) && canImport(CoreFoundation)

import func CoreFoundation.CFConvertDoubleSwappedToHost
import struct CoreFoundation.CFSwappedFloat32
import struct CoreFoundation.CFSwappedFloat64
import func CoreFoundation.memcpy // _DarwinFoundation2.memcpy
import struct Foundation.Data
import protocol Foundation.DataProtocol

extension Double {
    /// Returns `Data` representation of a `Double` value.
    @_disfavoredOverload
    public func toData(_ byteOrder: ByteOrder = .platformDefault) -> Data {
        var number = self

        return withUnsafeBytes(of: &number) { rawBuffer in
            rawBuffer.withMemoryRebound(to: UInt8.self) { buffer in
                switch byteOrder {
                case .littleEndian:
                    switch ByteOrder.platformDefault {
                    case .littleEndian:
                        Data(buffer: buffer)
                    case .bigEndian:
                        Data(Data(buffer: buffer).reversed())
                    }

                case .bigEndian:
                    switch ByteOrder.platformDefault {
                    case .littleEndian:
                        Data(Data(buffer: buffer).reversed())
                    case .bigEndian:
                        Data(buffer: buffer)
                    }
                }
            }
        }
    }
}

extension DataProtocol {
    /// Returns a `Double` value from `Data`.
    /// Returns `nil` if `self != 8 bytes`.
    @_disfavoredOverload
    public func toDouble(from byteOrder: ByteOrder = .platformDefault) -> Double? {
        guard count == 8 else {
            assertionFailure("Data byte length is incorrect. Expected 8 bytes but got \(count).")
            return nil
        }

        // define conversions

        // this crashes if Data alignment isn't correct
        // let number: Double = { self.withUnsafeBytes { $0.load(as: Double.self) } }()

        // since load(as:) is not memory alignment safe, memcpy is the current workaround
        // see for more info: https://bugs.swift.org/browse/SR-10273

        func number() -> Double? {
            if let self = self as? Data {
                self.withUnsafeBytes {
                    var value = Double()
                    memcpy(&value, $0.baseAddress!, 8)
                    return value
                }
            } else if let self = self as? [UInt8] {
                self.withUnsafeBytes {
                    var value = Double()
                    memcpy(&value, $0.baseAddress!, 8)
                    return value
                }
            } else {
                withContiguousStorageIfAvailable {
                    var value = Double()
                    memcpy(&value, $0.baseAddress!, 8)
                    return value
                }
            }
        }

        // double twiddling

        // swiftformat:disable all
        func numberSwapped() -> Double? {
            guard let swapped = if let self = self as? Data {
                self.withUnsafeBytes({
                    // $0.load(as: CFSwappedFloat64.self)
                    var value = CFSwappedFloat64()
                    memcpy(&value, $0.baseAddress!, 8)
                    return value
                })
            } else if let self = self as? [UInt8] {
                self.withUnsafeBytes({
                    // $0.load(as: CFSwappedFloat64.self)
                    var value = CFSwappedFloat64()
                    memcpy(&value, $0.baseAddress!, 8)
                    return value
                })
            } else {
                withContiguousStorageIfAvailable({
                    // $0.load(as: CFSwappedFloat64.self)
                    var value = CFSwappedFloat64()
                    memcpy(&value, $0.baseAddress!, 8)
                    return value
                })
            } else {
                return nil
            }
            return CFConvertDoubleSwappedToHost(swapped)
        }
        // swiftformat:enable all

        // determine which conversion is needed

        return switch byteOrder {
        case .littleEndian:
            switch ByteOrder.platformDefault {
            case .littleEndian: number()
            case .bigEndian: numberSwapped()
            }

        case .bigEndian:
            switch ByteOrder.platformDefault {
            case .littleEndian: numberSwapped()
            case .bigEndian: number()
            }
        }
    }
}

#endif
