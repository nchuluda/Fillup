//
//  IntroductionView.swift
//  Fillup
//
//  Created by Nathan on 2/24/24.
//

import SwiftUI

struct IntroductionView: View {
    @Binding var showIntroduction: Bool
    @State var sentence = "Recently I took a road trip from Michigan to South Carolina to visit my family. I drive a hybrid car, but even so, I kept needing to fillup my gas tank. It struck me that while I refill my car's tank again and again, I never see the fuel I'm purchasing."
    // I thought that by visually witnessing the scale of my consumption, I could better understand my impact.
    @State var numberOfClicks = 0
    @State var carOpacity = 1.0
    
    var sentences = [
        "It was uncomfortable realizing how easily I took this fuel for granted. I wondered what it would feel like to visualize my consumption habits.\n\nFillup lets users explore the scale of their gasoline consumption.",
        "I've added example vehicles to start off with, but if you drive a vehicle, I encourage you to add your own for a personalized experience.\n\nWhen you're ready, tap the \"Fillup Tank\" button.\n Let's get started!"
    ]

    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("car")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width)
                    .opacity(carOpacity)
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .frame(width: 500, height: 450)
                        .overlay {
                            RadialGradient(gradient: Gradient(colors: [.mint, .cyan]), center: .center, startRadius: 0.0, endRadius: 360.0)
                                .mask {
                                    RoundedRectangle(cornerRadius: 20.0)
                                        .frame(width: 500, height: 500)
                                }
                        }
                    VStack {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 160, height: 160)
                                Image("portrait")
                                    .resizable()
                                    .frame(maxWidth: 150, maxHeight: 150)
                                    .aspectRatio(contentMode: .fit)
                                    .mask {
                                        //                                Circle()
                                        RoundedRectangle(cornerRadius: 30)
                                            .frame(width: 150, height: 150)
                                    }
                            }
                            VStack {
                                Text("Hello! I'm Nathan,")
                                    .font(.title)
                                    .padding(.horizontal)
                                Text("and this is my car.")
                                    .font(.title3)
                                Text("Welcome to Fillup!")
                                    .font(.title2)
                                    .padding(.top, 10)
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        }
                        
                        VStack {
                            Spacer()
                            Text("\(sentence)")
                                .lineSpacing(10)
                                .fontWeight(.bold)
                                .padding()
                            Spacer()
                            HStack {
                                if numberOfClicks > 0 {
                                    Button(action: {
                                        numberOfClicks -= 1
                                        prev(numberOfClicks)
                                    }) {
                                        Text("Back")
                                            .padding()
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                            .background(.blue)
                                            .cornerRadius(100)
                                    }
                                    .padding(.horizontal)
                                }
                                Spacer()
                                Button(action: {
                                    numberOfClicks += 1
                                    next(numberOfClicks)
                                }) {
                                    Text("Next")
                                        .padding()
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .background(.blue)
                                        .cornerRadius(100)
                                }
                                .padding(.horizontal)
                                
                                //                        Button("Next") {
                                //                            print("next")
                                //                        }
                                //                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                //                        .fontWeight(.bold)
                                //                        .opacity(1.0)
                                //                        .frame(width: 100, height: 50)
                                //                        .buttonStyle(.borderedProminent)
                                //                        .buttonBorderShape(.capsule)
                                //                        .controlSize(.large)
                                //                        .padding(.horizontal)
                            }
                        }
                        .frame(width: 500, height: 290)
                        .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(40)
            }
        }
    }
    
    func prev(_ numberOfClicks: Int) {
        switch numberOfClicks {
        case 0:
            sentence = "Recently I took a road trip from Michigan to South Carolina to visit my family. I drive a hybrid car, but even so, I kept finding myself needing to fillup my gas tank. It struck me that while I refill my car's tank again and again, I never have to see the fuel I'm purchasing."
        case 1:
            sentence = sentences[0]
            withAnimation(.linear(duration: 1)) {
                carOpacity = 1.0
            }
        case 2:
            sentence = sentences[1]
        default:
            break
        }
    }
    
    func next(_ numberOfClicks: Int) {
        switch numberOfClicks {
        case 1:
            sentence = sentences[0]
        case 2:
            sentence = sentences[1]
            withAnimation(.linear(duration: 1)) {
                carOpacity = 0.0
            }
        case 3:
            showIntroduction = false
        default:
            break
        }
    }
}


#Preview {
    IntroductionView(showIntroduction: .constant(true))
}
