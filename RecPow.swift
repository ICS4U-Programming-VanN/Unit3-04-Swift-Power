//
//  StringStuff.swift
//
//  Created by Van
//  Created on 2024-04-17
//  Version 1.0
//  Copyright (c) 2024 Van Nguyen. All rights reserved.
//
//  Writes to output file the power of the base by the exponent

import Foundation

func power(base: Int, exponent: Int) -> Int {
    // Base case: if exponent is 0, return 1
    if exponent == 0 {
        return 1
    } else {
        // Recursive case: multiply base by power of base with reduced exponent
        return base * power(base: base, exponent: exponent - 1)
    }
}

// Function to read input from a file
func readInputFromFile(filePath: String) -> String? {
    do {
        // Attempt to read the contents of the file at the given file path
        let inputString = try String(contentsOfFile: filePath)
        return inputString // Return the contents of the file as a string
    } catch {
        // If an error occurs during file reading, print an error message and return nil
        print("Error reading input file: \(error)")
        return nil
    }
}

// Function to write output to a file
func writeOutputToFile(outputFilePath: String, output: String) {
    // Open an output stream to the specified file path
    guard let outputStream = OutputStream(toFileAtPath: outputFilePath, append: false) else {
        // If unable to open the output stream, print an error message and return
        print("Failed to open output file.")
        return
    }
    // Open the output stream
    outputStream.open()

    //https://www.hackingwithswift.com/new-syntax-swift-2-defer
    defer {
        // Close the output stream when the function exits
        outputStream.close()
    }

    // Convert the output string to an array of UTF-8 bytes
    let buffer = Array(output.utf8)

    // Write the buffer to the output stream
    let bytesWritten = outputStream.write(buffer, maxLength: buffer.count)
    if bytesWritten < 0 {
        // If an error occurs during writing, print an error message
        print("Error writing to output file.")
    }
}

// File paths
let inputFilePath = "./input.txt"
let outputFilePath = "./output.txt"

// Read input file
guard let inputString = readInputFromFile(filePath: inputFilePath) else {
    // If unable to read the input file, print an error message and exit
    fatalError("Unable to read input file.")
}

//https://developer.apple.com/documentation/foundation/nsstring/1413214-components
// Split the input string into lines
let lines = inputString.components(separatedBy: .newlines)

var output = "" // Initialize the output string
for line in lines {
    // Skip processing if the line is blank
    if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        continue
    }
    // For each non-blank line in the input file, find the maximum run of consecutive characters
    let components = line.components(separatedBy: .whitespaces)
    guard components.count == 2, let base = Int(components[0]), let exponent = Int(components[1]) else {
        print("Error: Invalid line format: \(line)")
        continue
    }
    // Calculate power and append the result to the output string
    let result = power(base: base, exponent: exponent)
    output += "Result: \(result)\n"
}

// Write output to file
writeOutputToFile(outputFilePath: outputFilePath, output: output)
