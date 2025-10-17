import SwiftUI

struct SpaceLaunchHeaderSection: View {
    let launch: SpaceLaunch
    var body: some View {
        HStack {
            Text(launch.name)
                .font(.headline)
            Spacer()
            Text(launch.status)
                .font(.caption)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(statusColor(for: launch.status))
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
    private func statusColor(for status: String) -> Color {
        switch status {
        case "Scheduled":
            return .blue
        case "Launched":
            return .green
        default:
            return .gray
        }
    }
}
