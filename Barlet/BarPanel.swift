import AppKit
import SwiftUI

/// 透明、不抢当前应用焦点的面板。系统玻璃要采到背后的桌面，窗口本身不能有底色。
final class BarPanel: NSPanel {
    nonisolated override var canBecomeKey: Bool { true }
    nonisolated override var canBecomeMain: Bool { false }

    init() {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 44),
            styleMask: [.borderless, .nonactivatingPanel, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        isFloatingPanel = true
        level = .floating
        collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .stationary, .ignoresCycle]
        hidesOnDeactivate = false
        isOpaque = false
        backgroundColor = .clear
        hasShadow = false
        isMovable = false
        titleVisibility = .hidden
        titlebarAppearsTransparent = true
        appearance = NSAppearance(named: .darkAqua)
    }
}

final class ClearHostingView<Content: View>: NSHostingView<Content> {
    nonisolated override var isOpaque: Bool { false }

    required init(rootView: Content) {
        super.init(rootView: rootView)
        sizingOptions = [.intrinsicContentSize]
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Barlet does not load views from a nib.")
    }
}

final class BarPanelController {
    private let panel = BarPanel()

    init() {
        let host = ClearHostingView(rootView: CapsuleBar())
        panel.contentView = host
    }

    func show() {
        resizeToContent()
        placeAboveDock()
        panel.orderFrontRegardless()
    }

    func hide() {
        panel.orderOut(nil)
    }

    private func resizeToContent() {
        guard let contentView = panel.contentView else { return }
        contentView.layoutSubtreeIfNeeded()
        let size = contentView.fittingSize
        guard size.width > 1, size.height > 1 else { return }
        var frame = panel.frame
        frame.size = size
        panel.setFrame(frame, display: true)
    }

    private func placeAboveDock() {
        guard let screen = NSScreen.main ?? NSScreen.screens.first else { return }
        let visible = screen.visibleFrame
        let size = panel.frame.size
        let origin = NSPoint(
            x: visible.midX - size.width / 2,
            y: visible.minY + 8
        )
        panel.setFrame(NSRect(origin: origin, size: size), display: true)
    }
}
