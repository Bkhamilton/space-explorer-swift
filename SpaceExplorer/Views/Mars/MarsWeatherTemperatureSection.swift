import SwiftUI

struct MarsWeatherTemperatureSection: View {
    let weather: MarsWeather
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("Temperature", systemImage: "thermometer")
                .font(.caption)
                .foregroundColor(.secondary)
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Min")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("\(weather.minTemp)°C")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Avg")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("\(weather.averageTemp)°C")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Max")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("\(weather.maxTemp)°C")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                Spacer()
                Text("\(weather.temperature.count) samples")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}