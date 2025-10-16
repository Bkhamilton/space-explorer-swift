import SwiftUI

struct MarsWeatherObservationPeriodSection: View {
    let firstUTC: String
    let lastUTC: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Observation Period")
                .font(.caption)
                .foregroundColor(.secondary)
            HStack {
                Text(formatUTCTime(firstUTC))
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text("→")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text(formatUTCTime(lastUTC))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
    private func formatUTCTime(_ utcString: String) -> String {
        if let tIndex = utcString.firstIndex(of: "T"),
           let zIndex = utcString.firstIndex(of: "Z") {
            let timeString = String(utcString[utcString.index(after: tIndex)..<zIndex])
            let components = timeString.split(separator: ":")
            if components.count >= 2 {
                return "\(components[0]):\(components[1]) UTC"
            }
        }
        return utcString
    }
}