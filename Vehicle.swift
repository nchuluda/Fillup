//
//  Vehicle.swift
//  Fillup
//
//  Created by Nathan on 2/22/24.
//

import Foundation

struct Vehicle: Identifiable {
    var id = UUID()
    var name: String
    var mileage: Double
    var mpg: Double
    var averagePricePerGallon: Double
    
    var totalGallons: Double {
        return mileage/mpg
    }
    
    var totalBottles: Int {
        return Int(totalGallons / 5)
    }
    
    var totalCost: String {
        let cost = totalGallons*averagePricePerGallon
        let formatted = String(format: "%.2f", cost)
        return formatted
    }
}
