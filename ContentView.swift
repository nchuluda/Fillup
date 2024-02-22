import SwiftUI

struct ContentView: View {
    @State var number: Double = 0
    @State var slider: Double = 0
    @State var tankExpanded = true
    
    var scaledImage: String {
        switch number {
        case 0:
            return "bottles0-min"
        case ..<120:
            return "bottles40x74"
        case 121...220:
            return "bottles30x56"
        case 221...420:
            return "bottles20x37"
        case 421...1000:
            return "bottles15x28"
        case 1001...2000:
            return "bottles10x19"
        case 2001...7500:
            return "bottles5x10"
        case 7501...25000:
            return "bottles3x6"
        default:
            return "bottles2x4"
        }
    }
    
    var bottleWidth: Double {
        switch number {
        case ..<120:
            return 40.0
        case 121...220:
            return 30.0
        case 221...420:
            return 20.0
        case 421...1000:
            return 15.0
        case 1001...2000:
            return 10.0
        case 2001...7500:
            return 5.0
        case 7501...25000:
            return 3.0
        default:
            return 2.0
        }
    }
    
    var bottleHeight: Double {
        switch number {
        case ..<120:
            return 74.0
        case 121...220:
            return 56.0
        case 221...420:
            return 37.0
        case 421...1000:
            return 28.0
        case 1001...2000:
            return 19.0
        case 2001...7500:
            return 10.0
        case 7501...25000:
            return 6.0
        default:
            return 4.0
        }
    }
    
    var tankWidth: Double {
        return max(280.0, x * bottleWidth)
    }
    
    var tankHeight: Double {
        if number == 0 {
            return 20.0
        } else {
            return y * bottleHeight
        }
    }
    
    var x: Double {
        return round(sqrt(number))
    }
    
    var y: Double {
        return ceil(sqrt(number))
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
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Button("Start Timed Bottles Animation") {
                            var index = 0
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                
                                
                                index += 1

                                if index == 14 {
                                    timer.invalidate()
                                }
                            }
                        }
            Slider(value: $number, in: -0...35000)
                .frame(width: 500)
            HStack {
                Text("\(floor(number), specifier: "%.1f")")
                    .padding()
                VStack {
                    Text("x: \(x) y: \(y)")
                    Text("tankWidth: \(tankWidth) tankHeight: \(tankHeight)")
                    Text("countX: \(countX) countY: \(countY)")
                    Text("Number of displayed bottles: \(displayedBottles)")
                }
            }
            
            // TOP
            UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 1, bottomTrailingRadius: 1, topTrailingRadius: 20, style: .continuous)
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
//                if tankExpanded {
                    Image(scaledImage)
                        .resizable(resizingMode: .tile)
                        .frame(width: tankWidth, height: tankHeight)
//                }
            }
            
            // BOTTOM
            UnevenRoundedRectangle(topLeadingRadius: 1,         bottomLeadingRadius: 20, bottomTrailingRadius: 20, topTrailingRadius: 1, style: .continuous)
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
            
        }
    }
}
