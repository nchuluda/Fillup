import SwiftUI

@main
struct MyApp: App {
    @StateObject var fillup = Fillup()
    @State var animatedCost: Double = 0.0
    @State var animatedBottles: Int = 0
    @State var animatedGallons: Int = 0
    @State var animatedBathTubs: Int = 0
    @State var animatedHotTubs: Int = 0
    @State var animatedTrucks: Double = 0.0
    
    var body: some Scene {
        WindowGroup {
            ContentView(fillup: fillup,
                        animatedCost: $animatedCost,
                        animatedBottles: $animatedBottles,
                        animatedGallons: $animatedGallons,
                        animatedBathTubs: $animatedBathTubs,
                        animatedHotTubs: $animatedHotTubs,
                        animatedTrucks: $animatedTrucks)
        }
    }
}
