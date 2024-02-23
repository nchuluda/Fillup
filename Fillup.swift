//
//  Fillup.swift
//  Fillup
//
//  Created by Nathan on 2/22/24.
//

import SwiftUI

class Fillup: ObservableObject {
    @Published var vehicles: [Vehicle] = [Vehicle(name: "Toyota Prius V", mileage: 113000.0, mpg: 42.0, averagePricePerGallon: 2.5), Vehicle(name: "Dodge RAM", mileage: 162000.0, mpg: 14.0, averagePricePerGallon: 2.5)]
}
