import SwiftUI

@main
struct ReplicateExampleApp: App {
    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView().frame(minWidth: 512, minHeight: 512).padding()
        }.windowStyle(.hiddenTitleBar)
        #else
        WindowGroup {
           ContentView()
        }
        #endif
    }
}
