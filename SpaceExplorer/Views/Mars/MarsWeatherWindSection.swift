import SwiftUI

struct MarsWeatherWindSection: View {
    let weather: MarsWeather
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("Wind Speed", systemImage: "wind")
                .font(.caption)
                .foregroundColor(.secondary)
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Min")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(String(format: "%.1f m/s", weather.windSpeed.minimum))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Avg")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(String(format: "%.1f m/s", weather.windSpeed.average))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Max")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(String(format: "%.1f m/s", weather.windSpeed.maximum))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                Spacer()
                Text("\(weather.windSpeed.count) samples")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}