//
//  Math.swift
//  SwiftDataParsing • https://github.com/orchetect/swift-data-parsing
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension FloatingPoint {
    /// Returns both integral part and fractional part.
    ///
    /// This method can result in a non-trivial loss of precision for the fractional part.
    @_disfavoredOverload @inlinable
    nonisolated
    var integralAndFraction: (integral: Self, fraction: Self) {
        let integral = rounded(.towardZero)
        let fraction = self - integral
        return (integral: integral, fraction: fraction)
    }
}
