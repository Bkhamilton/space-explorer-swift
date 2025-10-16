import Foundation

// MARK: - Nested Data Structures

struct TemperatureData {
    let average: Double
    let minimum: Double
    let maximum: Double
    let count: Int
}

struct PressureData {
    let average: Double
    let minimum: Double
    let maximum: Double
    let count: Int
}

struct WindSpeedData {
    let average: Double
    let minimum: Double
    let maximum: Double
    let count: Int
}

struct WindDirectionPoint {
    let compassDegrees: Double
    let compassPoint: String
    let compassRight: Double
    let compassUp: Double
    let count: Int
}

struct WindDirectionData {
    let mostCommon: WindDirectionPoint?
    let directions: [WindDirectionPoint]
}

// MARK: - Main Weather Model

struct MarsWeather: Identifiable {
    let id = UUID()
    let sol: Int
    let earthDate: String
    let firstUTC: String
    let lastUTC: String
    
    // Temperature
    let temperature: TemperatureData
    
    // Pressure
    let pressure: PressureData
    
    // Wind
    let windSpeed: WindSpeedData
    let windDirection: WindDirectionData?
    
    // Seasonal information
    let season: String
    let northernSeason: String
    let southernSeason: String
    let monthOrdinal: Int
    
    // Convenience properties for backward compatibility
    var minTemp: Int { Int(temperature.minimum) }
    var maxTemp: Int { Int(temperature.maximum) }
    var averageTemp: Int { Int(temperature.average) }
    var averagePressure: Int { Int(pressure.average) }
    var averageWindSpeed: Int { Int(windSpeed.average) }
}

// Hardcoded sample data
extension MarsWeather {
    static let sampleData: [MarsWeather] = [
        MarsWeather(
            sol: 4012,
            earthDate: "2024-10-15",
            firstUTC: "2024-10-15T00:00:00Z",
            lastUTC: "2024-10-15T23:59:59Z",
            temperature: TemperatureData(average: -62.3, minimum: -96.9, maximum: -15.9, count: 177556),
            pressure: PressureData(average: 750.6, minimum: 722.1, maximum: 768.8, count: 887776),
            windSpeed: WindSpeedData(average: 7.2, minimum: 1.1, maximum: 22.5, count: 88628),
            windDirection: WindDirectionData(
                mostCommon: WindDirectionPoint(compassDegrees: 292.5, compassPoint: "WNW", compassRight: -0.924, compassUp: 0.383, count: 30283),
                directions: []
            ),
            season: "fall",
            northernSeason: "early winter",
            southernSeason: "early summer",
            monthOrdinal: 10
        ),
        MarsWeather(
            sol: 4011,
            earthDate: "2024-10-14",
            firstUTC: "2024-10-14T00:00:00Z",
            lastUTC: "2024-10-14T23:59:59Z",
            temperature: TemperatureData(average: -64.5, minimum: -98.2, maximum: -18.5, count: 175432),
            pressure: PressureData(average: 748.3, minimum: 720.5, maximum: 765.2, count: 885123),
            windSpeed: WindSpeedData(average: 8.5, minimum: 1.3, maximum: 24.1, count: 87234),
            windDirection: WindDirectionData(
                mostCommon: WindDirectionPoint(compassDegrees: 270.0, compassPoint: "W", compassRight: -1.0, compassUp: 0.0, count: 28456),
                directions: []
            ),
            season: "fall",
            northernSeason: "early winter",
            southernSeason: "early summer",
            monthOrdinal: 10
        ),
        MarsWeather(
            sol: 4010,
            earthDate: "2024-10-13",
            firstUTC: "2024-10-13T00:00:00Z",
            lastUTC: "2024-10-13T23:59:59Z",
            temperature: TemperatureData(average: -59.8, minimum: -93.4, maximum: -17.2, count: 179234),
            pressure: PressureData(average: 752.1, minimum: 724.8, maximum: 771.5, count: 889456),
            windSpeed: WindSpeedData(average: 6.8, minimum: 0.9, maximum: 20.3, count: 89123),
            windDirection: WindDirectionData(
                mostCommon: WindDirectionPoint(compassDegrees: 315.0, compassPoint: "NW", compassRight: -0.707, compassUp: 0.707, count: 32145),
                directions: []
            ),
            season: "fall",
            northernSeason: "early winter",
            southernSeason: "early summer",
            monthOrdinal: 10
        ),
        MarsWeather(
            sol: 4009,
            earthDate: "2024-10-12",
            firstUTC: "2024-10-12T00:00:00Z",
            lastUTC: "2024-10-12T23:59:59Z",
            temperature: TemperatureData(average: -61.7, minimum: -95.8, maximum: -16.4, count: 176789),
            pressure: PressureData(average: 749.5, minimum: 721.9, maximum: 766.8, count: 886234),
            windSpeed: WindSpeedData(average: 7.9, minimum: 1.2, maximum: 23.7, count: 88456),
            windDirection: WindDirectionData(
                mostCommon: WindDirectionPoint(compassDegrees: 292.5, compassPoint: "WNW", compassRight: -0.924, compassUp: 0.383, count: 29876),
                directions: []
            ),
            season: "fall",
            northernSeason: "early winter",
            southernSeason: "early summer",
            monthOrdinal: 10
        ),
        MarsWeather(
            sol: 4008,
            earthDate: "2024-10-11",
            firstUTC: "2024-10-11T00:00:00Z",
            lastUTC: "2024-10-11T23:59:59Z",
            temperature: TemperatureData(average: -63.2, minimum: -97.1, maximum: -18.8, count: 174567),
            pressure: PressureData(average: 751.4, minimum: 723.6, maximum: 769.3, count: 887890),
            windSpeed: WindSpeedData(average: 7.5, minimum: 1.0, maximum: 21.8, count: 87890),
            windDirection: WindDirectionData(
                mostCommon: WindDirectionPoint(compassDegrees: 270.0, compassPoint: "W", compassRight: -1.0, compassUp: 0.0, count: 30123),
                directions: []
            ),
            season: "fall",
            northernSeason: "early winter",
            southernSeason: "early summer",
            monthOrdinal: 10
        )
    ]
}
