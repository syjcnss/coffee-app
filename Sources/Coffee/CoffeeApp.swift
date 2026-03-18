import SwiftUI

@main
struct CoffeeApp: App {
    @StateObject private var manager = CaffeineManager.shared
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        MenuBarExtra {
            ContentView(manager: manager)
        } label: {
            Image(systemName: manager.isActive ? "cup.and.heat.waves.fill" : "cup.and.heat.waves")
        }
        .menuBarExtraStyle(.window)
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillTerminate(_ notification: Notification) {
        CaffeineManager.shared.stopAndWait()
    }
}
