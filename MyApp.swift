import SwiftUI

@main
struct MyApp: App {
    @StateObject var fillup = Fillup()
    @State var animatedCost: Double = 0.0
    @State var animatedBottles: Int = 0
    @State var animatedGallons: Int = 0
    var body: some Scene {
        WindowGroup {
            ContentView(fillup: fillup,
                        animatedCost: $animatedCost,
                        animatedBottles: $animatedBottles,
                        animatedGallons: $animatedGallons)
        }
    }
}
