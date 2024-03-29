import SwiftUI

struct ContentView: View {
    @ObservedObject var fillup: Fillup
    @State var number: Int = 0
    @State var slider: Double = 0
    @State var tankExpanded = true
    
    @State var showAddVehicle = false
    @State var showIntroduction = true
    @State var showTankText = true
    @State var introductionOpacity = 1.0
    
    var theMaxWidth = 1.0
    
    @State var selectedVehicle: Vehicle?
    
    @State var selectedItem: Item = Item(image: "bottle1-min", aspectRatio: 432.0/800.0)
    
    
    @Binding var animatedCost: Double
    @Binding var animatedBottles: Int
    @Binding var animatedGallons: Int
    @Binding var animatedBathTubs: Int
    @Binding var animatedHotTubs: Int
    @Binding var animatedPools: Double
    @Binding var animatedTrucks: Double
    

    
    
    
    // EXPERIMENTAL ZONE FOR ADDITIONAL OBJECTS IN TANK
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

    let bottle = Item(image: "bottle1-min", aspectRatio: 432.0/800.0)
    let bathtub = Item(image: "bathtub", aspectRatio: 610.0/409.0)
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
                
//                print("x: \(x), y: \(y), calcX: \(calculatedWidth), calcY: \(calculatedHeight)")
                return (x: x, y: y, calculatedWidth: calculatedWidth, calculatedHeight: calculatedHeight)
            }
        }
        return (x: 1, y: 1, calculatedWidth: 1, calculatedHeight: 1)
    }
    // END EXPERIMENTAL ZONE
    
//    var scaledImage: String {
//        switch number {
//        case 0:
//            return "bottles0-min"
//        case ..<120:
//            return "bottles40x74"
//        case 121...220:
//            return "bottles30x56"
//        case 221...420:
//            return "bottles20x37"
//        case 421...1000:
//            return "bottles15x28"
//        case 1001...2000:
//            return "bottles10x19"
//        case 2001...7500:
//            return "bottles5x10"
//        case 7501...25000:
//            return "bottles3x6"
//        default:
//            return "bottles2x4"
//        }
//    }
    
    var scaledImageBorder: String {
        switch number {
        case 0:
            return "bottles0-min"
        case ..<120:
            return "bottles42x76"
        case 121...220:
            return "bottles32x58"
        case 221...420:
            return "bottles22x39"
        case 421...800:
            return "bottles17x30"
        case 801...1600:
            return "bottles12x21"
        case 1601...2400:
            return "bottles10x18"
        case 2401...7200:
            return "bottles7x12"
        case 7201...12500:
            return "bottles5x7"
        case 12501...25000:
            return "bottles3x5"
        default:
            return "bottles2x4"
        }
    }
    
    var bottleWidth: Double {
        switch number {
        case ..<120:
            return 42.0
        case 121...220:
            return 32.0
        case 221...420:
            return 22.0
        case 421...800:
            return 17.0
        case 801...1600:
            return 12.0
        case 1601...2400:
            return 10.0
        case 2401...7200:
            return 7.0
        case 7201...12500:
            return 5.0
        case 12501...25000:
            return 3.0
        default:
            return 2.0
        }
    }
    
    var bottleHeight: Double {
        switch number {
        case ..<120:
            return 76.0
        case 121...220:
            return 58.0
        case 221...420:
            return 39.0
        case 421...800:
            return 30.0
        case 801...1600:
            return 21.0
        case 1601...2400:
            return 18.0
        case 2401...7200:
            return 12.0
        case 7201...12500:
            return 7.0
        case 12501...25000:
            return 5.0
        default:
            return 4.0
        }
    }
    
//    var bottleWidth: Double {
//        switch number {
//        case ..<120:
//            return 40.0
//        case 121...220:
//            return 30.0
//        case 221...420:
//            return 20.0
//        case 421...1000:
//            return 15.0
//        case 1001...2000:
//            return 10.0
//        case 2001...7500:
//            return 5.0
//        case 7501...25000:
//            return 3.0
//        default:
//            return 2.0
//        }
//    }
//    
//    var bottleHeight: Double {
//        switch number {
//        case ..<120:
//            return 74.0
//        case 121...220:
//            return 56.0
//        case 221...420:
//            return 37.0
//        case 421...1000:
//            return 28.0
//        case 1001...2000:
//            return 19.0
//        case 2001...7500:
//            return 10.0
//        case 7501...25000:
//            return 6.0
//        default:
//            return 4.0
//        }
//    }
    
    var tankWidth: Double {
        return max(280.0, x * bottleWidth)
//        return max(280.0, x * (bottleWidth + 10))

    }
    
    var tankHeight: Double {
        if number == 0 {
            return 20.0
        } else {
            return y * bottleHeight
//            return y * (bottleWidth + 10)
        }
    }
    
    var x: Double {
        return round(sqrt(Double(number)))
    }
    
    var y: Double {
        return ceil(sqrt(Double(number)))
    }
    
    var countX: Int {
        return Int(tankWidth / bottleWidth)
    }
    
    var countY: Int {
        return Int(tankHeight / bottleHeight)
    }
    
    var displayedBottles: Int {
        return countX * countY
    }
    
    var timeInterval: Double {
        if number < 1000 {
            return 0.01
        } else if number < 2000 {
            return 0.005
        } else if number < 5000 {
            return 0.002
        } else {
            return 0.001
        }
    }
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
    //                VStack {
    //                    Text("Add your vehicle:")
    //                        .font(.title)
    //                    AddVehicleFormView(fillup: fillup)
    //                    Text("Number of displayed bottles: \(displayedBottles)")
                        VehicleView(fillup: fillup,
                                    number: $number,
                                    selectedVehicle: $selectedVehicle,
                                    animatedCost: $animatedCost,
                                    animatedBottles: $animatedBottles,
                                    animatedGallons: $animatedGallons,
                                    animatedBathTubs: $animatedBathTubs,
                                    animatedHotTubs: $animatedHotTubs,
                                    animatedPools: $animatedPools,
                                    animatedTrucks: $animatedTrucks,
                                    showAddVehicle: $showAddVehicle, 
                                    showTankText: $showTankText)
    //                        .border(.yellow)
    //                        .padding(20)
                        .frame(width: 275)
    //                    .border(.yellow)
    //                }
    //                .frame(width: 450, alignment: .topLeading)
    //                .border(.green)
    //                VStack {
    //                    if let currentVehicle = selectedVehicle {
    //                        Text("Your \(currentVehicle.name) has used \(animatedGallons) gallons of gasoline.")
    //                            .font(.title2)
    //                        Text("That's equal to  \(animatedBottles) 5-gallon water bottles")
    //                            .font(.title2)
    //                        Text("At $\(currentVehicle.averagePricePerGallon, specifier: "%.2f")/gal, that's $\(animatedCost, specifier: "%.2f")!")
    //                            .font(.title2)
    //                    }
    //                }
                    .padding(10)
                }
                .sheet(isPresented: $showAddVehicle) {
                    AddVehicleFormView(fillup: fillup)
                }
                
                
            
                
                Spacer()
                VStack {
                    Spacer()
                    if showTankText {
                        Text("How Big Is Your Tank?")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(20)
                    }
                    // TOP
                    UnevenRoundedRectangle(topLeadingRadius: 20,
                                           bottomLeadingRadius: 1,
                                           bottomTrailingRadius: 1,
                                           topTrailingRadius: 20,
                                           style: .continuous)
                                        .frame(width: tankWidth, height: 40)
                                        .foregroundColor(.gray)
                                        .overlay {
                                            HStack {
                                                Spacer()
                                                Image("tank-groove-top40")
                                                Spacer()
                                                Image("tank-groove-top40")
                                                Spacer()
                                                Image("tank-groove-top40")
                                                Spacer()
                                                Image("tank-groove-top40")
                                                Spacer()
                                                Image("tank-groove-top40")
                                                Spacer()
                                            }
                                        }
                    
                    // MIDDLE
                    ZStack {
                        Rectangle()
                            .frame(width: tankWidth, height: tankHeight)
                            .foregroundColor(.gray)
                            Image(scaledImageBorder)
                                .resizable(resizingMode: .tile)
                                .frame(width: tankWidth, height: tankHeight)
                                
                    }
                    
                    // BOTTOM
                    UnevenRoundedRectangle(topLeadingRadius: 1,
                                           bottomLeadingRadius: 20,
                                           bottomTrailingRadius: 20,
                                           topTrailingRadius: 1,
                                           style: .continuous)
                                        .frame(width: tankWidth, height: 40)
                                        .foregroundColor(.gray)
                                        .overlay {
                                            HStack {
                                                Spacer()
                                                Image("tank-groove-bottom40")
                                                Spacer()
                                                Image("tank-groove-bottom40")
                                                Spacer()
                                                Image("tank-groove-bottom40")
                                                Spacer()
                                                Image("tank-groove-bottom40")
                                                Spacer()
                                                Image("tank-groove-bottom40")
                                                Spacer()
                                            }
                                        }
                    Spacer()
                }
                .padding(20)
                .frame(minWidth: 800)
                .background(.black)
                .opacity(0.9)
                Spacer()
                VStack {
                    Spacer()
                    
                    
                    // DOLLARS
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                            .foregroundColor(.white)
                            .opacity(0.4)
                        
                        HStack {
                            Image("gas")
                                .resizable()
                                .frame(width: 61, height: 70)
                                .padding()
                            Spacer()
                            VStack {
//                                Text("$\(animatedCost, specifier: "%.2f")")
                                Text("$\(Int(animatedCost))")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text("Lifetime Fuel Cost")
                                    .font(.headline)
                            }
                            .foregroundColor(.black)
                            Spacer()
                        }
                        
                    
    //                            Spacer()
    //                            Text("\(animatedBottles)")
    //                                .font(.largeTitle)
    //                                .fontWeight(.bold)
    //                            Spacer()
                        
                    }
                    .frame(width: 300, height: 100)
                    
                    // GALLONS WITH IMAGE
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                            .foregroundColor(.white)
                            .opacity(0.4)
                            
                            HStack {
                                Image("milk")
                                    .resizable()
                                    .frame(width: 55, height: 70)
    //                                .padding(.horizontal, 25)
                                    .padding()
                                Spacer()
                                VStack {
                                    Text("\(animatedGallons)")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Text("Gallons")
                                        .font(.headline)
                                }
                                .foregroundColor(.black)
                                Spacer()
                            }
                    }
                    .frame(width: 300, height: 100)
                    
                    // BOTTLES
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                            .foregroundColor(.white)
                            .opacity(0.4)
                            
                            HStack {
                                Image("bottles1-min")
                                    .resizable()
                                    .frame(width: 40, height: 70)
    //                                .padding(.horizontal, 25)
                                    .padding()
                                Spacer()
                                VStack {
                                    Text("\(animatedBottles)")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Text("5 Gallon Bottles")
                                        .font(.headline)
                                }
                                .foregroundColor(.black)
                                Spacer()
                            }
                    }
                    .frame(width: 300, height: 100)
                    
                    // BATH TUBS
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                            .foregroundColor(.white)
                            .opacity(0.4)
                            
                        HStack {
                            Image("bathtub")
                                .resizable()
                                .frame(width: 70, height: 47)
                                .padding()
                            Spacer()
                            VStack {
                                Text("\(animatedBathTubs)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text("45 Gallon Bath Tubs")
                                    .font(.headline)
                            }
                            .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    .frame(width: 300, height: 100)
                    
                    // HOT TUBS
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                            .foregroundColor(.white)
                            .opacity(0.4)
                            
                        HStack {
                            Image("hottub")
                                .resizable()
                                .frame(width: 70, height: 52)
                                .padding()
                            Spacer()
                            VStack {
                                Text("\(animatedHotTubs)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text("350 Gallon Hot Tubs")
                                    .font(.headline)
                            }
                            .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    .frame(width: 300, height: 100)
                    
                    // HOT TUBS
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                            .foregroundColor(.white)
                            .opacity(0.4)
                            
                        HStack {
                            Image("pool")
                                .resizable()
                                .frame(width: 70, height: 46)
                                .padding()
                            Spacer()
                            VStack {
                                Text("\(animatedPools, specifier: "%.1f")")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text("3000 Gallon Pools")
                                    .font(.headline)
                            }
                            .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    .frame(width: 300, height: 100)
                    
//                    // TANKER TRUCKS
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
//                            .foregroundColor(.white)
//                            .opacity(0.4)
//                            
//                        HStack {
//                            Image("truck")
//                                .resizable()
//                                .frame(width: 70, height: 37)
//                                .padding()
//                            Spacer()
//                            VStack {
//                                Text("\(animatedTrucks, specifier: "%.1f")")
//                                    .font(.largeTitle)
//                                    .fontWeight(.bold)
//                                Text("4500 Gallon Tanker Trucks")
//                                    .font(.subheadline)
//                            }
//                            .foregroundColor(.black)
//                            Spacer()
//                        }
//                    }
//                    .frame(width: 300, height: 100)
                    
                    // TANKER TRUCKS REFORMATTED
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                            .foregroundColor(.white)
                            .opacity(0.4)
                            
                        VStack {
                            HStack {
                                Image("truck")
                                    .resizable()
                                    .frame(width: 70, height: 37)
                                    .padding()
                                Spacer()
                                Text("\(animatedTrucks, specifier: "%.1f")")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                                Text("4500 Gallon Tanker Trucks")
                                    .font(.headline)
                                    .padding(.bottom, 8)
                            }
                            .foregroundColor(.black)
                            Spacer()
                        }
                    
                    .frame(width: 300, height: 100)
                    Spacer()
                }
                .padding(20)
                Spacer()
            }
            .background(RadialGradient(gradient: Gradient(colors: [.green, .blue, .black]), center: .center, startRadius: 2, endRadius: 1200))
            .onChange(of: showIntroduction) { _ in
                withAnimation(.easeInOut(duration: 1)) {
                    introductionOpacity = 0.0
                }
            }

            IntroductionView(showIntroduction: $showIntroduction)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .opacity(introductionOpacity)
        }
    }
}
