//
//  ConvertCore.swift
//  Convert
//
//  Created by Igor Sapozhnikov on 30.09.2025.
//

public enum ConversionError: Error {
    case unsupportedUnit(String)
}

// Protocol for all unit types
public protocol UnitConvertible: RawRepresentable, CaseIterable where RawValue == String {
    static func convert(value: Double, from: Self, to: Self) throws -> Double
    static func transform(_ from: String) throws -> Self
    static func allUnitsString() -> String
}

extension UnitConvertible {
    public static func transform(_ from: String) throws -> Self {
        guard let unit = Self(rawValue: from) else {
            throw ConversionError.unsupportedUnit(
                "Invalid unit: \(from). Valid units: \(Self.allUnitsString())")
        }
        return unit
    }

    public static func allUnitsString() -> String {
        return Self.allCases.map { $0.rawValue }.joined(separator: ", ")
    }
}

// Distance units
public enum DistanceUnit: String, UnitConvertible {
    case kilometers = "km"
    case meters = "m"
    case miles = "mi"
    case yards = "yd"

    public static func convert(value: Double, from: DistanceUnit, to: DistanceUnit) throws -> Double {
        guard from != to else { return value }

        // Convert to meters first (base unit)
        let meters: Double
        switch from {
        case .meters:
            meters = value
        case .kilometers:
            meters = value * 1000
        case .miles:
            meters = value * 1609.34
        case .yards:
            meters = value * 0.9144
        }

        // Convert from meters to target unit
        switch to {
        case .meters:
            return meters
        case .kilometers:
            return meters / 1000
        case .miles:
            return meters / 1609.34
        case .yards:
            return meters / 0.9144
        }
    }
}

// Weight units
public enum WeightUnit: String, UnitConvertible {
    case kilograms = "kg"
    case grams = "g"
    case pounds = "lb"
    case ounces = "oz"

    public static func convert(value: Double, from: WeightUnit, to: WeightUnit) throws -> Double {
        guard from != to else { return value }

        // Convert to kilograms first (base unit)
        let kilograms: Double
        switch from {
        case .kilograms:
            kilograms = value
        case .grams:
            kilograms = value / 1000
        case .pounds:
            kilograms = value * 0.453592
        case .ounces:
            kilograms = value * 0.0283495
        }

        // Convert from kilograms to target unit
        switch to {
        case .kilograms:
            return kilograms
        case .grams:
            return kilograms * 1000
        case .pounds:
            return kilograms / 0.453592
        case .ounces:
            return kilograms / 0.0283495
        }
    }
}
