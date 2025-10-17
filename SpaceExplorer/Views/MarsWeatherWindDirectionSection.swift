import SwiftUI

struct MarsWeatherWindDirectionSection: View {
    let mostCommon: MarsWindDirection.MostCommon
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("Most Common Wind Direction", systemImage: "location.north.fill")
                .font(.caption)
                .foregroundColor(.secondary)
            HStack(spacing: 12) {
                Text(mostCommon.compassPoint)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(Int(mostCommon.compassDegrees))°")
                        .font(.subheadline)
                    Text("\(mostCommon.count) observations")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
    }
}