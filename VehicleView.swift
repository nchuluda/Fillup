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
    
    @Binding var selectedVehicle: Vehicle?
    
    @Binding var animatedCost: Double
    @Binding var animatedBottles: Int
    @Binding var animatedGallons: Int
    @Binding var animatedBathTubs: Int
    @Binding var animatedHotTubs: Int
    @Binding var animatedPools: Double
    @Binding var animatedTrucks: Double
    
    @Binding var showAddVehicle: Bool
    @Binding var showTankText: Bool
    
    let steelGray = Color(white: 0.4745)
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    
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
        Spacer()
        ScrollView {
            ForEach(fillup.vehicles) { vehicle in
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 50.0,
                    bottomLeading: 20.0,
                    bottomTrailing: 50.0,
                    topTrailing: 20.0),
                                       style: .continuous)
//                .fill(.blue)
                .foregroundColor(.white)
                .opacity(0.4)
                .frame(width: 250, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay {
                    VStack {
                        Text(vehicle.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            
                            .padding()
                        Text("Mileage: \(Int(vehicle.mileage))")
                        Text("MPG: \(Int(vehicle.mpg))")
                        Text("Price per gallon: $\(vehicle.averagePricePerGallon, specifier: "%.2f")")
                            .padding(.bottom, 5)
                        Button("⛽️ Fillup Tank") {
//                        Button {

                            showTankText = false
                            selectedVehicle = vehicle
                            var index = 1
                            total = vehicle.totalBottles
                            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
                                number = index
                                animatedCost = Double(index) * vehicle.averagePricePerGallon * 5
                                animatedGallons = Int(Double(index) * 5.0)
                                animatedBottles = index
                                animatedBathTubs = Int(index / 9)
                                animatedHotTubs = Int(index / 70)
                                animatedPools = round((Double(index) / 600.0) * 10)/10.0
                                animatedTrucks = round((Double(index) / 900.0) * 10)/10.0
                                index += 1
                                
                                if index >= Int(total) {
                                    timer.invalidate()
                                    animatedCost = floor(vehicle.totalGallons) * vehicle.averagePricePerGallon
                                    animatedGallons = Int(vehicle.totalGallons)
                                    animatedBottles = Int(vehicle.totalBottles)
                                    animatedHotTubs = Int(vehicle.totalGallons / 45)
                                    animatedHotTubs = Int(vehicle.totalGallons / 350)
                                    animatedPools = round((vehicle.totalGallons / 3000) * 10) / 10.0
                                    animatedTrucks = round((vehicle.totalGallons / 4500) * 10) / 10.0
                                }
                            }
//                        } label: {
//                            HStack {
//                                Image("gas")
//                                    .resizable()
//                                    .frame(width: 20, height: 23)
//                                Text("Fillup Tank")
//                            }.padding(5)
                        }
                        .fontWeight(.bold)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .tint(.white.opacity(0.4))
                    }
                    .foregroundColor(.black)
                }
                
            }

        }
        .frame(height: 860)
        //
        Button("􀅼 Add Your Vehicle") {
            showAddVehicle.toggle()
        }
        
        .font(.title2)
        .fontWeight(.bold)
//        .frame(width: 300, height: 100)
        .foregroundColor(.black)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(.white.opacity(0.7))
        .opacity(0.8)
        Spacer()
    }
}






