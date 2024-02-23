import SwiftUI

@main
struct MyApp: App {
    @StateObject var fillup = Fillup()
    var body: some Scene {
        WindowGroup {
            ContentView(fillup: fillup)
        }
    }
}
