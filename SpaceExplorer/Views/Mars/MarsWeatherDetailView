import SwiftUI

// Detail view for a single MarsWeather object.
// Kept separate so the card remains lightweight and reusable.
struct MarsWeatherDetailView: View {
    let weather: MarsWeather

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Sol \(weather.sol)")
                    .font(.largeTitle)
                    .bold()

                HStack {
                    Text(weather.earthDate)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(weather.season.capitalized)
                        .font(.headline)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.orange.opacity(0.2))
                        .cornerRadius(8)
                }

                Divider()

                Group {
                    Text("Temperatures")
                        .font(.headline)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Min")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("\(weather.minTemp)°C")
                                .font(.title3)
                                .bold()
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Avg")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("\(weather.averageTemp)°C")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.blue)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Max")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("\(weather.maxTemp)°C")
                                .font(.title3)
                                .bold()
                        }
                    }
                }

                Divider()

                Group {
                    Text("Pressure")
                        .font(.headline)
                    HStack {
                        Text("Min: \(Int(weather.pressure.minimum)) Pa")
                        Spacer()
                        Text("Avg: \(weather.averagePressure) Pa")
                        Spacer()
                        Text("Max: \(Int(weather.pressure.maximum)) Pa")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }

                Divider()

                Group {
                    Text("Wind")
                        .font(.headline)
                    HStack {
                        Text("Min: \(String(format: \"%.1f m/s\", weather.windSpeed.minimum))")
                        Spacer()
                        Text("Avg: \(String(format: \"%.1f m/s\", weather.windSpeed.average))")
                        Spacer()
                        Text("Max: \(String(format: \"%.1f m/s\", weather.windSpeed.maximum))")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }

                if let windDir = weather.windDirection, let mostCommon = windDir.mostCommon {
                    Divider()
                    Text("Wind Direction")
                        .font(.headline)
                    HStack {
                        Text(mostCommon.compassPoint)
                            .font(.title)
                            .bold()
                            .foregroundColor(.blue)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("\(Int(mostCommon.compassDegrees))°")
                            Text("\(mostCommon.count) observations")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Sol \(weather.sol)")
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

struct MarsWeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MarsWeatherDetailView(weather: MarsWeather.sampleData[0])
        }
    }
}
