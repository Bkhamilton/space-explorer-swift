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
                            MarsWeatherHeaderSection(weather: weather)
                            MarsWeatherSeasonSection(weather: weather)
                            Divider()
                            MarsWeatherTemperatureSection(weather: weather)
                            Divider()
                            MarsWeatherPressureSection(weather: weather)
                            Divider()
                            MarsWeatherWindSection(weather: weather)
                            if let windDir = weather.windDirection, let mostCommon = windDir.mostCommon {
                                Divider()
                                MarsWeatherWindDirectionSection(mostCommon: mostCommon)
                            }
                            Divider()
                            MarsWeatherObservationPeriodSection(firstUTC: weather.firstUTC, lastUTC: weather.lastUTC)
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
