import SwiftUI

struct MarsWeatherPressureSection: View {
    let weather: MarsWeather
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("Atmospheric Pressure", systemImage: "gauge")
                .font(.caption)
                .foregroundColor(.secondary)
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Min")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("\(Int(weather.pressure.minimum)) Pa")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Avg")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("\(weather.averagePressure) Pa")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Max")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("\(Int(weather.pressure.maximum)) Pa")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                Spacer()
                Text("\(weather.pressure.count) samples")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}