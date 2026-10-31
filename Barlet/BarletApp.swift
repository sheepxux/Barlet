import AppKit
import SwiftUI

@main
struct BarletApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        MenuBarExtra("Barlet", systemImage: "capsule") {
            Button("显示") {
                appDelegate.panel.show()
            }
            Button("隐藏") {
                appDelegate.panel.hide()
            }
            Divider()
            Button("退出") {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    let panel = BarPanelController()

    func applicationDidFinishLaunching(_ notification: Notification) {
        panel.show()
    }
}
