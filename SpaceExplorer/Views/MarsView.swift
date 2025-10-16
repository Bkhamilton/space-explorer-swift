import SwiftUI

struct MarsView: View {
    @State private var weatherData: [MarsWeather] = MarsWeather.sampleData
    @State private var isLoading = false
    @State private var errorMessage: String?
    
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
        
        InSightService.shared.fetchMarsWeather { result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let data):
                    let parsedWeather = InSightService.shared.parseMarsWeatherData(from: data)
                    if !parsedWeather.isEmpty {
                        weatherData = parsedWeather
                    } else {
                        errorMessage = "InSight mission ended. Showing sample data."
                    }
                case .failure(let error):
                    errorMessage = "InSight mission ended. Showing sample data."
                    print("Failed to load Mars weather: \(error)")
                }
            }
        }
    }
}

#Preview {
    MarsView()
}
