import ArgumentParser
import ConvertCore

@main
struct Convert: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A utility for converting between different units",
        subcommands: [Distance.self, Weight.self],
        defaultSubcommand: nil
    )
}

// MARK: - Distance subcommand
extension Convert {
    struct Distance: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Convert distance units (\(DistanceUnit.allUnitsString()))"
        )

        @Argument(help: "Value to convert")
        var value: Double

        @Option(name: .shortAndLong, help: "Source unit (\(DistanceUnit.allUnitsString()))", transform: DistanceUnit.transform)
        var from: DistanceUnit

        @Option(name: .shortAndLong, help: "Target unit (\(DistanceUnit.allUnitsString()))", transform: DistanceUnit.transform)
        var to: DistanceUnit

        func run() throws {
            // Perform conversion
            let result = try DistanceUnit.convert(value: value, from: from, to: to)

            // Print result
            print("\(value) \(from) = \(result) \(to)")
        }
    }
}

// MARK: - Weight subcommand
extension Convert {
    struct Weight: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Convert weight units (\(WeightUnit.allUnitsString()))"
        )

        @Argument(help: "Value to convert")
        var value: Double

        @Option(name: .shortAndLong, help: "Source unit (\(WeightUnit.allUnitsString()))", transform: WeightUnit.transform)
        var from: WeightUnit

        @Option(name: .shortAndLong, help: "Target unit (\(WeightUnit.allUnitsString()))", transform: WeightUnit.transform)
        var to: WeightUnit

        func run() throws {
            // Perform conversion
            let result = try WeightUnit.convert(value: value, from: from, to: to)

            // Print result
            print("\(value) \(from) = \(result) \(to)")
        }
    }
}
