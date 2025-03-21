//
//  ContentView.swift
//  VoluMate
//
//  Created by Kamol Madaminov on 22/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var chosenUnit = "mL"
    @State private var chosenVolume = 100
    
    private let units = ["mL", "L", "gal", "qt", "pt", "cup"]
    var outputUnits: [String] {
        units.filter { $0 != chosenUnit }
    }
    
    func convert(_ volume: Double, from inputUnit: String, to outputUnit: String) -> Double {
        
        let baseValue: Double
        
        switch inputUnit {
        case "mL": baseValue = volume
        case "L": baseValue = volume * 1000
        case "gal": baseValue = volume * 3785.41
        case "qt": baseValue = volume * 946.353
        case "pt": baseValue = volume * 473.176
        case "cup": baseValue = volume * 236.588
        default: return 0
        }
        
        switch outputUnit {
        case "mL": return baseValue
        case "L": return baseValue / 1000
        case "gal": return baseValue / 3785.41
        case "qt": return baseValue / 946.353
        case "pt": return baseValue / 473.176
        case "cup": return baseValue / 236.588
        default: return 0
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter the parameters") {
                    TextField("Volume", value: $chosenVolume, format: .number)
                        .keyboardType(.decimalPad)
                    Picker("Choosing a unit", selection: $chosenUnit){
                        ForEach(units, id: \.self){
                            Text("\($0) unit")
                        }
                    }
                }
                Section("Output"){
                    ForEach(outputUnits, id: \.self){
                        Text("\(convert(Double(chosenVolume), from: chosenUnit, to: $0), specifier: "%.2f") \($0)")
                    }
                }
            }
            .navigationTitle("VoluMate")
        }
    }
}

#Preview {
    ContentView()
}
