import SwiftUI

/// A reusable card view that displays brief info about a SpaceLaunch.
/// Keep this small and focused so you can reuse it in lists or grids.
struct SpaceLaunchCard: View {
    let launch: SpaceLaunch
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
            
            HStack {
                Label(launch.agency, systemImage: "building.2")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
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
            
            HStack {
                Label(launch.location, systemImage: "location.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
    
    // Keep the status color here for now; if other views need it you can move to a shared helper/extension
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

struct SpaceLaunchCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SpaceLaunchCard(launch: SpaceLaunch.sampleData.first!)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
