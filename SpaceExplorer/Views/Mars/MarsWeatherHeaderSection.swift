import SwiftUI

struct MarsWeatherHeaderSection: View {
    let weather: MarsWeather
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Sol \(weather.sol)")
                    .font(.headline)
                Text(weather.earthDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(weather.season.capitalized)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(8)
                Text("Month \(weather.monthOrdinal)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}