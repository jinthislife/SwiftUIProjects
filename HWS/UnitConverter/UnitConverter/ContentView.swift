//
//  ContentView.swift
//  UnitConverter
//
//  Created by Jin Lee on 9/7/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

enum LengthUnits: Int, CaseIterable {
    
    case Meters, Kilometers, Feet, Yards, Miles
    
    var name: String {
        switch self {
        case .Meters: return "Meters"
        case .Kilometers: return "Kilometers"
        case .Feet: return "Feet"
        case .Yards: return "Yards"
        case .Miles: return "Miles"
        }
    }
}

struct ContentView: View {

    @State private var userInput = ""
    @State private var inputSelection = 0
    @State private var outputSelection = 0
    
    private var convertedBaseValue: Double {
        var baseValue: Double = 0 // millimeters
        guard let inputUnit = LengthUnits(rawValue: inputSelection) else { return 0 }
        
        switch inputUnit {
        case .Meters:
            baseValue = 1000
        case .Kilometers:
            baseValue = 1000000
        case .Feet:
            baseValue = 304.8
        case .Yards:
            baseValue = 914.4
        case .Miles:
            baseValue = 1609347.2186944
        }
        return baseValue * (Double(userInput) ?? 0)
    }
    
    private var convertedOutputValue: Double {
        
        var convertMultiplier: Double = 0
        
        guard let outputUnit = LengthUnits(rawValue: outputSelection) else { return 0 }
        switch outputUnit {
        case .Meters:
            convertMultiplier = 0.001
        case .Kilometers:
            convertMultiplier = 0.000001
        case .Feet:
            convertMultiplier = 0.00328084
        case .Yards:
            convertMultiplier = 0.001093613
        case .Miles:
            convertMultiplier = 0.000000621
        }
        
        return convertedBaseValue * convertMultiplier
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input unit: ", text: $userInput)
                    .keyboardType(.decimalPad)
                }
                
                Section {
                    Picker("Input unit", selection: $inputSelection) {
                        ForEach(0 ..< LengthUnits.allCases.count) {
                            Text("\(LengthUnits(rawValue: $0)?.name ?? "")")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Output unit", selection: $outputSelection) {
                        ForEach(0 ..< LengthUnits.allCases.count) {
                            Text("\(LengthUnits(rawValue: $0)?.name ?? "")")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Section {
                    Text("\(convertedOutputValue, specifier: "%.4f") \(LengthUnits(rawValue: outputSelection)?.name ?? "")")
                }
                
            }
        .navigationBarTitle("Length Converter")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
