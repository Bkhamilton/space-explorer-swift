import SwiftUI

struct SpaceLaunchAgencySection: View {
    let launch: SpaceLaunch
    var body: some View {
        HStack {
            Label(launch.agency, systemImage: "building.2")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
