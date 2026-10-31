import SwiftUI

/// 三个区域的静态骨架。按钮还没有接到动作层。
struct CapsuleBar: View {
    var body: some View {
        HStack(spacing: 36) {
            HStack(spacing: 8) {
                BarSymbol(systemName: "chevron.backward", label: "后退")
                BarSymbol(systemName: "chevron.forward", label: "前进")
                BarSymbol(systemName: "arrow.clockwise", label: "重新载入")
            }
            HStack(spacing: 8) {
                BarSymbol(systemName: "play.fill", label: "播放")
                BarSymbol(systemName: "speaker.wave.2.fill", label: "音量")
                BarSymbol(systemName: "sun.max.fill", label: "亮度")
                BarSymbol(systemName: "chevron.left", label: "展开")
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background {
            Capsule()
                .fill(Color(red: 33 / 255, green: 32 / 255, blue: 30 / 255))
        }
        .glassEffect(.clear, in: .capsule)
        .preferredColorScheme(.dark)
    }
}

private struct BarSymbol: View {
    let systemName: String
    let label: String

    var body: some View {
        Button {} label: {
            Image(systemName: systemName)
                .font(.system(size: 17, weight: .medium))
                .frame(width: 48, height: 44)
                .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .foregroundStyle(Color.white)
        .accessibilityLabel(label)
    }
}
