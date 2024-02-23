//
//  AddVehicleView.swift
//  Fillup
//
//  Created by Nathan on 2/22/24.
//

import SwiftUI

struct AddVehicleView: View {
    @ObservedObject var fillup: Fillup
    @State var name: String = ""
    @State var mileage: Double = 0.0
    @State var mpg: Double = 0.0
    @State var averagePricePerGallon: Double = 0.0
    
    var body: some View {
        Form {
            Section {
                TextField("Vehicle Model/Name", text: $name)
                
//                TextField("Total Mileage", value: $mileage, formatter: formatter)
//                TextField("Estimated MPG", value: $mpg, format: .number)
                
//                TextField("Average Price Per Gallon", value: $averagePricePerGallon, format: .number)
            } header: {
                Text("Vehicle Model/Name")
            }
            
            HStack {
                Text("Total Mileage")
                Spacer()
                Text("\(Int(mileage))")
            }
            Slider(value: $mileage, in: 0...400000, step: 10)

            
            HStack {
                Text("Estimated MPG")
                Spacer()
                Text("\(Int(mpg))")
            }
            Slider(value: $mpg, in: 0...100, step: 1)
            
            HStack {
                Text("Average Price Per Gallon: ")
                Spacer()
                Text("$\(averagePricePerGallon, specifier: "%.2f")")
            }
            Slider(value: $averagePricePerGallon, in: 0...10.00, step: 0.01)
            
            
            Section {
                Button("Add Vehicle") {
                    fillup.vehicles.append(Vehicle(name: name, mileage: mileage, mpg: mpg, averagePricePerGallon: averagePricePerGallon))
                    name = ""
                    mpg = 0.0
                    mileage = 0.0
                    averagePricePerGallon = 0.0
                }
            }
        }
        .frame(width: 400)
    }
}
