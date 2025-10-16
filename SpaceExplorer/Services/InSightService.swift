import Foundation
import Combine

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
    
    // Combine-based method for fetching Mars weather
    func fetchMarsWeatherPublisher() -> AnyPublisher<[MarsWeather], Error> {
        let apiKey = APIConfiguration.nasaAPIKey
        guard let url = URL(string: "https://api.nasa.gov/insight_weather/?api_key=\(apiKey)&feedtype=json&ver=1.0") else {
            return Fail(error: NSError(domain: "InSightService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .map { [weak self] data in
                self?.parseMarsWeatherData(from: data) ?? []
            }
            .eraseToAnyPublisher()
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
                        
                        // Extract temperature data
                        var tempData = TemperatureData(average: -62.3, minimum: -96.9, maximum: -15.9, count: 177556)
                        if let at = solData["AT"] as? [String: Any] {
                            let avg = at["av"] as? Double ?? -62.3
                            let min = at["mn"] as? Double ?? -96.9
                            let max = at["mx"] as? Double ?? -15.9
                            let ct = at["ct"] as? Int ?? 177556
                            tempData = TemperatureData(average: avg, minimum: min, maximum: max, count: ct)
                        }
                        
                        // Extract pressure data
                        var pressureData = PressureData(average: 750.6, minimum: 722.1, maximum: 768.8, count: 887776)
                        if let pre = solData["PRE"] as? [String: Any] {
                            let avg = pre["av"] as? Double ?? 750.6
                            let min = pre["mn"] as? Double ?? 722.1
                            let max = pre["mx"] as? Double ?? 768.8
                            let ct = pre["ct"] as? Int ?? 887776
                            pressureData = PressureData(average: avg, minimum: min, maximum: max, count: ct)
                        }
                        
                        // Extract wind speed data
                        var windSpeedData = WindSpeedData(average: 7.2, minimum: 1.1, maximum: 22.5, count: 88628)
                        if let hws = solData["HWS"] as? [String: Any] {
                            let avg = hws["av"] as? Double ?? 7.2
                            let min = hws["mn"] as? Double ?? 1.1
                            let max = hws["mx"] as? Double ?? 22.5
                            let ct = hws["ct"] as? Int ?? 88628
                            windSpeedData = WindSpeedData(average: avg, minimum: min, maximum: max, count: ct)
                        }
                        
                        // Extract wind direction data
                        var windDirectionData: WindDirectionData? = nil
                        if let wd = solData["WD"] as? [String: Any],
                           let mostCommonData = wd["most_common"] as? [String: Any] {
                            let degrees = mostCommonData["compass_degrees"] as? Double ?? 0.0
                            let point = mostCommonData["compass_point"] as? String ?? "N"
                            let right = mostCommonData["compass_right"] as? Double ?? 0.0
                            let up = mostCommonData["compass_up"] as? Double ?? 1.0
                            let ct = mostCommonData["ct"] as? Int ?? 0
                            
                            let mostCommon = WindDirectionPoint(
                                compassDegrees: degrees,
                                compassPoint: point,
                                compassRight: right,
                                compassUp: up,
                                count: ct
                            )
                            
                            windDirectionData = WindDirectionData(mostCommon: mostCommon, directions: [])
                        }
                        
                        // Extract season and date information
                        let season = solData["Season"] as? String ?? "Unknown"
                        let northernSeason = solData["Northern_season"] as? String ?? "Unknown"
                        let southernSeason = solData["Southern_season"] as? String ?? "Unknown"
                        let monthOrdinal = solData["Month_ordinal"] as? Int ?? 1
                        
                        let firstUTC = solData["First_UTC"] as? String ?? ""
                        let lastUTC = solData["Last_UTC"] as? String ?? ""
                        let earthDate = extractDate(from: firstUTC)
                        
                        let weather = MarsWeather(
                            sol: sol,
                            earthDate: earthDate,
                            firstUTC: firstUTC,
                            lastUTC: lastUTC,
                            temperature: tempData,
                            pressure: pressureData,
                            windSpeed: windSpeedData,
                            windDirection: windDirectionData,
                            season: season,
                            northernSeason: northernSeason,
                            southernSeason: southernSeason,
                            monthOrdinal: monthOrdinal
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
