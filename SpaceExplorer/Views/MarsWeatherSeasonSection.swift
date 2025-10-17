import SwiftUI

struct MarsWeatherSeasonSection: View {
    let weather: MarsWeather
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text("North: \(weather.northernSeason)")
                    .font(.caption)
                    .foregroundColor(.blue)
                Text("South: \(weather.southernSeason)")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
            Spacer()
        }
    }
}