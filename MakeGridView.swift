//
//  MakeGridView.swift
//  Fillup
//
//  Created by Nathan on 2/25/24.
//

import SwiftUI

struct MakeGridView: View {
    @State var grid: (x: Int, y: Int, calculatedWidth: Int, calculatedHeight: Int) = (x: 0, y: 0, calculatedWidth: 0, calculatedHeight: 0)
    
    @State var xCount = 2
    @State var yCount = 2
    
    @State var calcW = 50.0
    @State var calcH = 40.0
    
    @State var tankW = 500
    @State var tankH = 100
    
    @State var remainder = 0
    
    @State var image = "hottub"
    
    let aspectRatio = 0.6

    let bottle = Item(image: "bottle1-min", aspectRatio: 432.0/800)
    let bathtub = Item(image: "bathtub", aspectRatio: 610.0/409)
    let hotTub = Item(image: "hottub", aspectRatio: 401.0/503.0)
    let pool = Item(image: "pool", aspectRatio: 617.0/405.0)
    let tanker = Item(image: "tanker", aspectRatio: 684.0/365.0)
    
    
    
    
    func getBestFit(_ number: Int, _ item: Item) -> (x: Int, y: Int, calculatedWidth: Int, calculatedHeight: Int) {
        for i in 1...number {
            let x = i
            let y = Int(ceil(Double(number) / Double(x)))
            if Double(x)/Double(y) > aspectRatio {
                let calculatedWidth = Int(floor(Double(tankW)/Double(x)))
                let calculatedHeight = Int(floor(item.aspectRatio * Double(calculatedWidth)))
                
                
                
                
                print("x: \(x), y: \(y), calcX: \(calculatedWidth), calcY: \(calculatedHeight)")
                return (x: x, y: y, calculatedWidth: calculatedWidth, calculatedHeight: calculatedHeight)
            }
        }
        return (x: 1, y: 1, calculatedWidth: 1, calculatedHeight: 1)
    }
    
    var body: some View {
        Button("257") {
            let input = 257
            let item = hotTub
            
            image = item.image
            
            grid = getBestFit(input, item)
            xCount = getBestFit(input, item).x
            
            calcW = Double(getBestFit(input, item).calculatedWidth)
            calcH = Double(getBestFit(input, item).calculatedHeight)
            
            if input % xCount == 0 {
                yCount = getBestFit(input, item).y
            } else {
                yCount = getBestFit(input, item).y - 1
                remainder = input % xCount
            }
        }
        

    }
}
