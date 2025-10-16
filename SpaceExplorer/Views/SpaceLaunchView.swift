import SwiftUI

struct SpaceLaunchView: View {
    let launches = SpaceLaunch.sampleData
    
    var body: some View {
        NavigationView {
            List(launches) { launch in
                VStack(alignment: .leading, spacing: 10) {
                    SpaceLaunchHeaderSection(launch: launch)
                    SpaceLaunchAgencySection(launch: launch)
                    Divider()
                    SpaceLaunchDateTypeSection(launch: launch)
                    SpaceLaunchLocationSection(launch: launch)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Space Launches")
        }
    }
    
    // statusColor logic moved to SpaceLaunchHeaderSection
}

#Preview {
    SpaceLaunchView()
}
