import Foundation

struct MarsWeather: Identifiable {
    let id = UUID()
    let sol: Int
    let earthDate: String
    let minTemp: Int
    let maxTemp: Int
    let pressure: Int
    let windSpeed: Int
    let season: String
}

// Hardcoded sample data
extension MarsWeather {
    static let sampleData: [MarsWeather] = [
        MarsWeather(
            sol: 4012,
            earthDate: "2024-10-15",
            minTemp: -89,
            maxTemp: -18,
            pressure: 750,
            windSpeed: 12,
            season: "Month 6"
        ),
        MarsWeather(
            sol: 4011,
            earthDate: "2024-10-14",
            minTemp: -92,
            maxTemp: -15,
            pressure: 748,
            windSpeed: 15,
            season: "Month 6"
        ),
        MarsWeather(
            sol: 4010,
            earthDate: "2024-10-13",
            minTemp: -87,
            maxTemp: -20,
            pressure: 752,
            windSpeed: 10,
            season: "Month 6"
        ),
        MarsWeather(
            sol: 4009,
            earthDate: "2024-10-12",
            minTemp: -91,
            maxTemp: -17,
            pressure: 749,
            windSpeed: 14,
            season: "Month 6"
        ),
        MarsWeather(
            sol: 4008,
            earthDate: "2024-10-11",
            minTemp: -88,
            maxTemp: -19,
            pressure: 751,
            windSpeed: 11,
            season: "Month 6"
        )
    ]
}
