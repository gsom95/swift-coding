import Testing
@testable import ConvertCore

@Suite("Distance Unit Conversion Tests")
struct DistanceUnitTests {

    @Test("Convert kilometers to meters")
    func testKilometersToMeters() throws {
        let result = try DistanceUnit.convert(value: 5, from: .kilometers, to: .meters)
        #expect(result == 5000)
    }

    @Test("Convert meters to kilometers")
    func testMetersToKilometers() throws {
        let result = try DistanceUnit.convert(value: 1000, from: .meters, to: .kilometers)
        #expect(result == 1)
    }

    @Test("Convert miles to kilometers")
    func testMilesToKilometers() throws {
        let result = try DistanceUnit.convert(value: 10, from: .miles, to: .kilometers)
        #expect(abs(result - 16.0934) < 0.01)
    }

    @Test("Convert kilometers to miles")
    func testKilometersToMiles() throws {
        let result = try DistanceUnit.convert(value: 16.0934, from: .kilometers, to: .miles)
        #expect(abs(result - 10) < 0.01)
    }

    @Test("Convert yards to meters")
    func testYardsToMeters() throws {
        let result = try DistanceUnit.convert(value: 100, from: .yards, to: .meters)
        #expect(abs(result - 91.44) < 0.01)
    }

    @Test("Convert meters to yards")
    func testMetersToYards() throws {
        let result = try DistanceUnit.convert(value: 91.44, from: .meters, to: .yards)
        #expect(abs(result - 100) < 0.01)
    }

    @Test("Convert same unit returns same value")
    func testSameUnitConversion() throws {
        let result = try DistanceUnit.convert(value: 42, from: .kilometers, to: .kilometers)
        #expect(result == 42)
    }

    @Test("Convert miles to yards")
    func testMilesToYards() throws {
        let result = try DistanceUnit.convert(value: 1, from: .miles, to: .yards)
        #expect(abs(result - 1760) < 1)
    }

}

@Suite("Weight Unit Conversion Tests")
struct WeightUnitTests {

    @Test("Convert kilograms to grams")
    func testKilogramsToGrams() throws {
        let result = try WeightUnit.convert(value: 2.5, from: .kilograms, to: .grams)
        #expect(result == 2500)
    }

    @Test("Convert grams to kilograms")
    func testGramsToKilograms() throws {
        let result = try WeightUnit.convert(value: 1000, from: .grams, to: .kilograms)
        #expect(result == 1)
    }

    @Test("Convert pounds to kilograms")
    func testPoundsToKilograms() throws {
        let result = try WeightUnit.convert(value: 10, from: .pounds, to: .kilograms)
        #expect(abs(result - 4.53592) < 0.001)
    }

    @Test("Convert kilograms to pounds")
    func testKilogramsToPounds() throws {
        let result = try WeightUnit.convert(value: 4.53592, from: .kilograms, to: .pounds)
        #expect(abs(result - 10) < 0.01)
    }

    @Test("Convert ounces to grams")
    func testOuncesToGrams() throws {
        let result = try WeightUnit.convert(value: 16, from: .ounces, to: .grams)
        #expect(abs(result - 453.592) < 0.1)
    }

    @Test("Convert grams to ounces")
    func testGramsToOunces() throws {
        let result = try WeightUnit.convert(value: 453.592, from: .grams, to: .ounces)
        #expect(abs(result - 16) < 0.01)
    }

    @Test("Convert same unit returns same value")
    func testSameUnitConversion() throws {
        let result = try WeightUnit.convert(value: 100, from: .kilograms, to: .kilograms)
        #expect(result == 100)
    }

    @Test("Convert pounds to ounces")
    func testPoundsToOunces() throws {
        let result = try WeightUnit.convert(value: 1, from: .pounds, to: .ounces)
        #expect(abs(result - 16) < 0.1)
    }
}

@Suite("Unit Validation Tests")
struct UnitValidationTests {

    @Test("DistanceUnit has correct raw values")
    func testDistanceUnitRawValues() {
        #expect(DistanceUnit.kilometers.rawValue == "km")
        #expect(DistanceUnit.meters.rawValue == "m")
        #expect(DistanceUnit.miles.rawValue == "mi")
        #expect(DistanceUnit.yards.rawValue == "yd")
    }

    @Test("WeightUnit has correct raw values")
    func testWeightUnitRawValues() {
        #expect(WeightUnit.kilograms.rawValue == "kg")
        #expect(WeightUnit.grams.rawValue == "g")
        #expect(WeightUnit.pounds.rawValue == "lb")
        #expect(WeightUnit.ounces.rawValue == "oz")
    }

    @Test("DistanceUnit can be initialized from raw value")
    func testDistanceUnitInitialization() {
        #expect(DistanceUnit(rawValue: "km") == .kilometers)
        #expect(DistanceUnit(rawValue: "m") == .meters)
        #expect(DistanceUnit(rawValue: "mi") == .miles)
        #expect(DistanceUnit(rawValue: "yd") == .yards)
        #expect(DistanceUnit(rawValue: "invalid") == nil)
    }

    @Test("WeightUnit can be initialized from raw value")
    func testWeightUnitInitialization() {
        #expect(WeightUnit(rawValue: "kg") == .kilograms)
        #expect(WeightUnit(rawValue: "g") == .grams)
        #expect(WeightUnit(rawValue: "lb") == .pounds)
        #expect(WeightUnit(rawValue: "oz") == .ounces)
        #expect(WeightUnit(rawValue: "invalid") == nil)
    }
}
