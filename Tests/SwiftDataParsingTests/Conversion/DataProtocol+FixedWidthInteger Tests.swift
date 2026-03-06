//
//  DataProtocol+FixedWidthInteger Tests.swift
//  swift-data-parsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation) && canImport(CoreFoundation)

import Foundation
import SwiftDataParsing
import Testing

@Suite struct DataProtocol_FixedWidthInteger_Tests {
    @Test
    func memoryAlignment() async {
        // test for misaligned raw pointer (memory alignment)
        
        // if the underlying `Data -> T: FixedWidthInteger` method is not properly aligned, this test
        // will trigger a runtime exception
        
        // cycle through 8 memory offset positions regardless of the type we're testing
        for offset in 1 ... 8 {
            let offSetBytes = Data([UInt8](repeating: 0x00, count: offset))
            
            // integers
            
            _ = (offSetBytes + Int8(1).toData(.bigEndian))[offset ... offset]
                .toInt8()
            
            _ = (offSetBytes + UInt8(1).toData(.bigEndian))[offset ... offset]
                .toUInt8()
            
            _ = (offSetBytes + Int16(1).toData(.bigEndian))[offset ... offset + 1]
                .toInt16(from: .bigEndian)
            
            _ = (offSetBytes + UInt16(1).toData(.bigEndian))[offset ... offset + 1]
                .toUInt16(from: .bigEndian)
            
            _ = (offSetBytes + Int32(1).toData(.bigEndian))[offset ... offset + 3]
                .toInt32(from: .bigEndian)
            
            _ = (offSetBytes + UInt32(1).toData(.bigEndian))[offset ... offset + 3]
                .toUInt32(from: .bigEndian)
            
            _ = (offSetBytes + Int64(1).toData(.bigEndian))[offset ... offset + 7]
                .toInt64(from: .bigEndian)
            
            _ = (offSetBytes + UInt64(1).toData(.bigEndian))[offset ... offset + 7]
                .toUInt64(from: .bigEndian)
            
            // floating-point
            
            _ = (offSetBytes + Float32(1).toData(.bigEndian))[offset ... offset + 3]
                .toFloat32(from: .bigEndian)
            
            _ = (offSetBytes + Double(1).toData(.bigEndian))[offset ... offset + 7]
                .toDouble(from: .bigEndian)
        }
    }
    
    @Test
    func memoryAlignment_uInt8Array() async {
        // test for misaligned raw pointer (memory alignment)
        
        // if the underlying `Data -> T: FixedWidthInteger` method is not properly aligned, this test
        // will trigger a runtime exception
        
        // cycle through 8 memory offset positions regardless of the type we're testing
        for offset in 1 ... 8 {
            let offSetBytes = [UInt8](repeating: 0x00, count: offset)
            
            // integers
            
            _ = (offSetBytes + Int8(1).toData(.bigEndian))[offset ... offset]
                .toInt8()
            
            _ = (offSetBytes + UInt8(1).toData(.bigEndian))[offset ... offset]
                .toUInt8()
            
            _ = (offSetBytes + Int16(1).toData(.bigEndian))[offset ... offset + 1]
                .toInt16(from: .bigEndian)
            
            _ = (offSetBytes + UInt16(1).toData(.bigEndian))[offset ... offset + 1]
                .toUInt16(from: .bigEndian)
            
            _ = (offSetBytes + Int32(1).toData(.bigEndian))[offset ... offset + 3]
                .toInt32(from: .bigEndian)
            
            _ = (offSetBytes + UInt32(1).toData(.bigEndian))[offset ... offset + 3]
                .toUInt32(from: .bigEndian)
            
            _ = (offSetBytes + Int64(1).toData(.bigEndian))[offset ... offset + 7]
                .toInt64(from: .bigEndian)
            
            _ = (offSetBytes + UInt64(1).toData(.bigEndian))[offset ... offset + 7]
                .toUInt64(from: .bigEndian)
            
            // floating-point
            
            _ = (offSetBytes + Float32(1).toData(.bigEndian))[offset ... offset + 3]
                .toFloat32(from: .bigEndian)
            
            _ = (offSetBytes + Double(1).toData(.bigEndian))[offset ... offset + 7]
                .toDouble(from: .bigEndian)
        }
    }
}

#endif
