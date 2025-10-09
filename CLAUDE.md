# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Convert is a Swift Package Manager (SPM) project for unit conversions, targeting macOS 15+ and Swift 6.2. The project consists of:

- **ConvertCore**: A library module providing the core conversion logic
- **Convert**: An executable target that uses ArgumentParser for CLI interface

## Architecture

### Module Structure

- `Sources/ConvertCore/ConvertCore.swift`: Core conversion engine with unit definitions and conversion logic
  - `ConversionError`: Error handling for unsupported units and invalid conversions
  - `UnitConvertible`: Protocol defining the interface for all unit types, requiring `RawRepresentable`, `CaseIterable`, and a `convert(value:from:to:)` method
  - `DistanceUnit`: Enum for distance conversions (km, m, mi, yd) using meters as the base unit
  - `WeightUnit`: Enum for weight conversions (kg, g, lb, oz) using kilograms as the base unit
  - Conversion logic uses a two-step process: convert to base unit, then to target unit

- `Sources/Convert/Convert.swift`: CLI entry point using ArgumentParser's `ParsableCommand` protocol with subcommands
  - `Convert.Distance`: Subcommand for distance conversions with `--value`, `--from`, and `--to` options
  - `Convert.Weight`: Subcommand for weight conversions with `--value`, `--from`, and `--to` options
  - Unit validation occurs before conversion, providing clear error messages for invalid units

- `Tests/ConvertCoreTests/ConvertCoreTests.swift`: Comprehensive test suite using Swift Testing framework
  - `DistanceUnitTests`: 8 tests covering distance conversions
  - `WeightUnitTests`: 8 tests covering weight conversions
  - `UnitValidationTests`: 4 tests validating raw values and initialization

### Design Notes

- The conversion system uses a protocol-based architecture (`UnitConvertible`) for extensibility
- Each unit type converts through a base unit (meters for distance, kilograms for weight) to support any pair conversion
- Adding new unit categories requires creating an enum conforming to `UnitConvertible` and adding a corresponding subcommand
- CLI uses ArgumentParser's subcommand feature for clean organization of different unit categories
- All unit strings are validated before conversion, preventing runtime errors

## Common Commands

### Build
```bash
swift build
```

### Run
```bash
# Show help
swift run Convert --help

# Convert distance
swift run Convert distance --value 5 --from km --to m

# Convert weight
swift run Convert weight --value 10 --from lb --to kg

# Get subcommand help
swift run Convert distance --help
swift run Convert weight --help
```

### Test
```bash
swift test
```

### Clean Build
```bash
swift package clean
```

### Update Dependencies
```bash
swift package update
```

### Generate Xcode Project (if needed)
```bash
swift package generate-xcodeproj
```

## Dependencies

- **swift-argument-parser** (1.6.1+): Used for CLI argument parsing in the executable target
