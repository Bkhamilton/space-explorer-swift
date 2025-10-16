import SwiftUI

struct MarsView: View {
    let weatherData = MarsWeather.sampleData
    
    var body: some View {
        NavigationView {
            List(weatherData) { weather in
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Sol \(weather.sol)")
                                .font(.headline)
                            Text(weather.earthDate)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text(weather.season)
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(8)
                    }
                    
                    Divider()
                    
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Label("Temperature", systemImage: "thermometer")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(weather.minTemp)°C to \(weather.maxTemp)°C")
                                .font(.subheadline)
                                .bold()
                        }
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Label("Pressure", systemImage: "gauge")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(weather.pressure) Pa")
                                .font(.subheadline)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Label("Wind Speed", systemImage: "wind")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(weather.windSpeed) m/s")
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Mars Weather")
        }
    }
}

#Preview {
    MarsView()
}
