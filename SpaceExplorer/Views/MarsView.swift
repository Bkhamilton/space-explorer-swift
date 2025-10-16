import SwiftUI
import Combine

struct MarsView: View {
    @State private var _weatherData: [MarsWeather] = MarsWeather.sampleData
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var cancellables = Set<AnyCancellable>()
    
    // Public accessor for testing
    var weatherData: [MarsWeather] {
        return _weatherData
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading Mars weather...")
                        .padding()
                }
                
                if let error = errorMessage {
                    Text("Note: \(error)")
                        .foregroundColor(.orange)
                        .font(.caption)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                
                List(_weatherData) { weather in
                    VStack(alignment: .leading, spacing: 12) {
                        // Header Section
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
                        
                        // Seasonal Information
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
                        
                        Divider()
                        
                        // Temperature Section
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
                        
                        Divider()
                        
                        // Pressure Section
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
                        
                        Divider()
                        
                        // Wind Section
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
                        
                        // Wind Direction Section (if available)
                        if let windDir = weather.windDirection, let mostCommon = windDir.mostCommon {
                            Divider()
                            
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
                        
                        // UTC Time Range
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Observation Period")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            HStack {
                                Text(formatUTCTime(weather.firstUTC))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Text("→")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Text(formatUTCTime(weather.lastUTC))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
                .navigationTitle("Mars Weather")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: loadMarsWeather) {
                            Image(systemName: "arrow.clockwise")
                        }
                        .disabled(isLoading)
                    }
                }
            }
        }
        .onAppear {
            loadMarsWeather()
        }
    }
    
    private func loadMarsWeather() {
        isLoading = true
        errorMessage = nil
        
        InSightService.shared.fetchMarsWeatherPublisher()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [self] completion in
                    isLoading = false
                    
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        errorMessage = "InSight mission ended. Showing sample data."
                        print("Failed to load Mars weather: \(error)")
                    }
                },
                receiveValue: { [self] parsedWeather in
                    if !parsedWeather.isEmpty {
                        _weatherData = parsedWeather
                    } else {
                        errorMessage = "InSight mission ended. Showing sample data."
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    private func formatUTCTime(_ utcString: String) -> String {
        // Format: "2020-10-19T18:32:20Z" -> "18:32 UTC"
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

#Preview {
    MarsView()
}
