import SwiftUI

/// Placeholder detail view for a SpaceLaunch.
/// Expand this with full content (images, links, extended descriptions, telemetry, etc.)
struct SpaceLaunchDetailView: View {
    let launch: SpaceLaunch
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(launch.name)
                    .font(.largeTitle)
                    .bold()
                
                Text(launch.status)
                    .font(.subheadline)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(statusColor(for: launch.status))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Label("Agency", systemImage: "building.2")
                        Spacer()
                        Text(launch.agency)
                    }
                    
                    HStack {
                        Label("Date", systemImage: "calendar")
                        Spacer()
                        Text(launch.launchDate)
                    }
                    
                    HStack {
                        Label("Mission Type", systemImage: "tag")
                        Spacer()
                        Text(launch.missionType)
                    }
                    
                    HStack {
                        Label("Location", systemImage: "location.fill")
                        Spacer()
                        Text(launch.location)
                    }
                }
                .font(.body)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Launch Details")
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

struct SpaceLaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpaceLaunchDetailView(launch: SpaceLaunch.sampleData.first!)
        }
    }
}