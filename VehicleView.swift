//
//  VehicleView.swift
//  Fillup
//
//  Created by Nathan on 2/22/24.
//

import SwiftUI

struct VehicleView: View {
    @ObservedObject var fillup: Fillup
    @Binding var number: Int
    @State var total: Int = 0
    
    
    var timeInterval: Double {
        if total < 1000 {
            return 0.01
        } else if total < 2000 {
            return 0.005
        } else if total < 5000 {
            return 0.002
        } else {
            return 0.001
        }
    }
    
    var body: some View {
        ScrollView {
            ForEach(fillup.vehicles) { vehicle in
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 50.0,
                    bottomLeading: 20.0,
                    bottomTrailing: 50.0,
                    topTrailing: 20.0),
                                       style: .continuous)
                .fill(.blue)
                .frame(width: 300, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay {
                    VStack {
                        Text(vehicle.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        Text("Mileage: \(Int(vehicle.mileage))")
                        Text("MPG: \(Int(vehicle.mpg))")
                        Text("Price per gallon: $\(vehicle.averagePricePerGallon)")
                            .padding(.bottom, 5)
                        Button("Fillup Tank") {
                            var index = 1
                            total = vehicle.totalBottles
                            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
                                
                                number = index
    //                            withAnimation(.linear(duration: 1)) {
                                    index += 1
    //                            }
                                if index >= Int(total) {
                                    timer.invalidate()
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
}
