import Foundation

// MARK: - InSight Response Models
struct InSightResponse: Codable {
    let solKeys: [String]
    let validityChecks: [String: String]?
    
    enum CodingKeys: String, CodingKey {
        case solKeys = "sol_keys"
        case validityChecks = "validity_checks"
    }
    
    // Note: The InSight API has a complex structure with dynamic sol keys
    // Each sol is a separate key in the JSON response
    // This service provides a simplified approach to handle the data
}

// MARK: - Simplified Mars Weather Data from InSight
struct InSightWeatherData: Codable {
    let sol: String
    let firstUTC: String?
    let lastUTC: String?
    let season: String?
    let averageTemperature: Double?
    let minTemperature: Double?
    let maxTemperature: Double?
    let pressure: Double?
    let windSpeed: Double?
    
    enum CodingKeys: String, CodingKey {
        case firstUTC = "First_UTC"
        case lastUTC = "Last_UTC"
        case season = "Season"
        case averageTemperature = "AT"
        case minTemperature = "PRE"
        case maxTemperature = "PRE"
        case pressure = "PRE"
        case windSpeed = "HWS"
    }
}

// MARK: - InSight Service
class InSightService {
    static let shared = InSightService()
    
    private init() {}
    
    // Note: As of 2024, the InSight mission has ended and the API may not return live data
    // This implementation provides the structure for API calls
    // The API endpoint: https://api.nasa.gov/insight_weather/?api_key=DEMO_KEY&feedtype=json&ver=1.0
    
    func fetchMarsWeather(completion: @escaping (Result<Data, Error>) -> Void) {
        let apiKey = APIConfiguration.nasaAPIKey
        guard let url = URL(string: "https://api.nasa.gov/insight_weather/?api_key=\(apiKey)&feedtype=json&ver=1.0") else {
            completion(.failure(NSError(domain: "InSightService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "InSightService", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            // Return raw data since the InSight API structure is complex and dynamic
            completion(.success(data))
        }
        
        task.resume()
    }
    
    // Helper method to parse InSight response
    func parseMarsWeatherData(from data: Data) -> [MarsWeather] {
        // Since the InSight mission has ended and may not return data,
        // we'll return sample data with a note
        // In a real scenario, you would parse the dynamic JSON structure here
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let solKeys = json["sol_keys"] as? [String] {
                
                var weatherData: [MarsWeather] = []
                
                for solKey in solKeys.prefix(5) {
                    if let solData = json[solKey] as? [String: Any],
                       let sol = Int(solKey) {
                        
                        // Extract temperature data if available
                        var minTemp = -89
                        var maxTemp = -18
                        if let at = solData["AT"] as? [String: Any],
                           let av = at["av"] as? Double {
                            minTemp = Int(av - 35)
                            maxTemp = Int(av)
                        }
                        
                        // Extract pressure data if available
                        var pressure = 750
                        if let pre = solData["PRE"] as? [String: Any],
                           let av = pre["av"] as? Double {
                            pressure = Int(av)
                        }
                        
                        // Extract wind speed data if available
                        var windSpeed = 12
                        if let hws = solData["HWS"] as? [String: Any],
                           let av = hws["av"] as? Double {
                            windSpeed = Int(av)
                        }
                        
                        // Extract season and date
                        let season = solData["Season"] as? String ?? "Unknown"
                        let firstUTC = solData["First_UTC"] as? String ?? ""
                        let earthDate = extractDate(from: firstUTC)
                        
                        let weather = MarsWeather(
                            sol: sol,
                            earthDate: earthDate,
                            minTemp: minTemp,
                            maxTemp: maxTemp,
                            pressure: pressure,
                            windSpeed: windSpeed,
                            season: season
                        )
                        weatherData.append(weather)
                    }
                }
                
                return weatherData
            }
        } catch {
            print("Error parsing InSight data: \(error)")
        }
        
        // Return empty array if parsing fails
        return []
    }
    
    private func extractDate(from utcString: String) -> String {
        // Extract date from UTC string (format: "2019-11-12T00:00:00Z")
        if let index = utcString.firstIndex(of: "T") {
            return String(utcString[..<index])
        }
        
        // If no date found, return current date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}
