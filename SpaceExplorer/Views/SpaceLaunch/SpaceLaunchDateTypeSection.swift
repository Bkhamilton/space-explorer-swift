import SwiftUI

struct SpaceLaunchDateTypeSection: View {
    let launch: SpaceLaunch
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 4) {
                Label("Date", systemImage: "calendar")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(launch.launchDate)
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Label("Type", systemImage: "tag")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(launch.missionType)
                    .font(.subheadline)
            }
        }
    }
}
