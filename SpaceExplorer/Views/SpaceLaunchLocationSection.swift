import SwiftUI

struct SpaceLaunchLocationSection: View {
    let launch: SpaceLaunch
    var body: some View {
        HStack {
            Label(launch.location, systemImage: "location.fill")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
