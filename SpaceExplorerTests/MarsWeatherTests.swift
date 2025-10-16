import XCTest
@testable import SpaceExplorer

final class MarsWeatherTests: XCTestCase {
    
    // MARK: - Model Creation Tests
    
    func testMarsWeatherInitialization() {
        // Given
        let sol = 4012
        let earthDate = "2024-10-15"
        let firstUTC = "2024-10-15T00:00:00Z"
        let lastUTC = "2024-10-15T23:59:59Z"
        let temperature = TemperatureData(average: -62.3, minimum: -96.9, maximum: -15.9, count: 177556)
        let pressure = PressureData(average: 750.6, minimum: 722.1, maximum: 768.8, count: 887776)
        let windSpeed = WindSpeedData(average: 7.2, minimum: 1.1, maximum: 22.5, count: 88628)
        let season = "fall"
        let northernSeason = "early winter"
        let southernSeason = "early summer"
        let monthOrdinal = 10
        
        // When
        let weather = MarsWeather(
            sol: sol,
            earthDate: earthDate,
            firstUTC: firstUTC,
            lastUTC: lastUTC,
            temperature: temperature,
            pressure: pressure,
            windSpeed: windSpeed,
            windDirection: nil,
            season: season,
            northernSeason: northernSeason,
            southernSeason: southernSeason,
            monthOrdinal: monthOrdinal
        )
        
        // Then
        XCTAssertEqual(weather.sol, sol)
        XCTAssertEqual(weather.earthDate, earthDate)
        XCTAssertEqual(weather.firstUTC, firstUTC)
        XCTAssertEqual(weather.lastUTC, lastUTC)
        XCTAssertEqual(weather.temperature.average, temperature.average)
        XCTAssertEqual(weather.temperature.minimum, temperature.minimum)
        XCTAssertEqual(weather.temperature.maximum, temperature.maximum)
        XCTAssertEqual(weather.pressure.average, pressure.average)
        XCTAssertEqual(weather.windSpeed.average, windSpeed.average)
        XCTAssertEqual(weather.season, season)
        XCTAssertEqual(weather.northernSeason, northernSeason)
        XCTAssertEqual(weather.southernSeason, southernSeason)
        XCTAssertEqual(weather.monthOrdinal, monthOrdinal)
        XCTAssertNotNil(weather.id)
    }
    
    func testMarsWeatherHasUniqueID() {
        // Given & When
        let weather1 = MarsWeather(
            sol: 4012,
            earthDate: "2024-10-15",
            firstUTC: "2024-10-15T00:00:00Z",
            lastUTC: "2024-10-15T23:59:59Z",
            temperature: TemperatureData(average: -62.3, minimum: -96.9, maximum: -15.9, count: 177556),
            pressure: PressureData(average: 750.6, minimum: 722.1, maximum: 768.8, count: 887776),
            windSpeed: WindSpeedData(average: 7.2, minimum: 1.1, maximum: 22.5, count: 88628),
            windDirection: nil,
            season: "fall",
            northernSeason: "early winter",
            southernSeason: "early summer",
            monthOrdinal: 10
        )
        let weather2 = MarsWeather(
            sol: 4013,
            earthDate: "2024-10-16",
            firstUTC: "2024-10-16T00:00:00Z",
            lastUTC: "2024-10-16T23:59:59Z",
            temperature: TemperatureData(average: -63.2, minimum: -97.8, maximum: -16.5, count: 176234),
            pressure: PressureData(average: 751.3, minimum: 723.4, maximum: 769.5, count: 888123),
            windSpeed: WindSpeedData(average: 7.8, minimum: 1.2, maximum: 23.1, count: 89012),
            windDirection: nil,
            season: "fall",
            northernSeason: "early winter",
            southernSeason: "early summer",
            monthOrdinal: 10
        )
        
        // Then
        XCTAssertNotEqual(weather1.id, weather2.id)
    }
    
    // MARK: - Temperature Validation Tests
    
    func testMinTemperatureIsLessThanMaxTemperature() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            XCTAssertLessThan(weather.temperature.minimum, weather.temperature.maximum, 
                "Min temperature should be less than max temperature for sol \(weather.sol)")
        }
    }
    
    func testMarsTemperaturesAreRealistic() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            // Mars temperatures typically range from -125°C to 20°C
            XCTAssertGreaterThanOrEqual(weather.temperature.minimum, -125, 
                "Min temperature should be within realistic Mars range for sol \(weather.sol)")
            XCTAssertLessThanOrEqual(weather.temperature.maximum, 20, 
                "Max temperature should be within realistic Mars range for sol \(weather.sol)")
        }
    }
    
    // MARK: - Sample Data Tests
    
    func testSampleDataIsNotEmpty() {
        // Given & When
        let sampleData = MarsWeather.sampleData
        
        // Then
        XCTAssertFalse(sampleData.isEmpty, "Sample data should not be empty")
    }
    
    func testSampleDataHasExpectedCount() {
        // Given & When
        let sampleData = MarsWeather.sampleData
        
        // Then
        XCTAssertEqual(sampleData.count, 5, "Sample data should contain 5 weather entries")
    }
    
    func testSampleDataHasValidProperties() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            XCTAssertGreaterThan(weather.sol, 0, "Sol should be positive")
            XCTAssertFalse(weather.earthDate.isEmpty, "Earth date should not be empty")
            XCTAssertGreaterThan(weather.pressure.average, 0, "Pressure should be positive")
            XCTAssertGreaterThanOrEqual(weather.windSpeed.average, 0, "Wind speed should be non-negative")
            XCTAssertFalse(weather.season.isEmpty, "Season should not be empty")
            XCTAssertFalse(weather.northernSeason.isEmpty, "Northern season should not be empty")
            XCTAssertFalse(weather.southernSeason.isEmpty, "Southern season should not be empty")
            XCTAssertGreaterThan(weather.monthOrdinal, 0, "Month ordinal should be positive")
        }
    }
    
    func testSampleDataContainsSol4012() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When
        let sol4012 = sampleData.first { $0.sol == 4012 }
        
        // Then
        XCTAssertNotNil(sol4012, "Sample data should contain sol 4012")
        XCTAssertEqual(sol4012?.earthDate, "2024-10-15")
    }
    
    func testSampleDataSolsAreInDescendingOrder() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for i in 0..<(sampleData.count - 1) {
            XCTAssertGreaterThan(sampleData[i].sol, sampleData[i + 1].sol,
                "Sols should be in descending order")
        }
    }
    
    // MARK: - Atmospheric Data Tests
    
    func testMarsAtmosphericPressureIsRealistic() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            // Mars atmospheric pressure typically ranges from 400 to 870 Pascals
            XCTAssertGreaterThanOrEqual(weather.pressure.average, 400, 
                "Pressure should be within realistic Mars range for sol \(weather.sol)")
            XCTAssertLessThanOrEqual(weather.pressure.average, 870, 
                "Pressure should be within realistic Mars range for sol \(weather.sol)")
        }
    }
    
    func testWindSpeedIsRealistic() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            // Mars wind speeds typically range from 0 to 60 m/s
            XCTAssertGreaterThanOrEqual(weather.windSpeed.average, 0, 
                "Wind speed should be non-negative for sol \(weather.sol)")
            XCTAssertLessThanOrEqual(weather.windSpeed.average, 60, 
                "Wind speed should be within realistic Mars range for sol \(weather.sol)")
        }
    }
    
    // MARK: - Identifiable Conformance Tests
    
    func testMarsWeatherConformsToIdentifiable() {
        // Given
        let weather = MarsWeather(
            sol: 4012,
            earthDate: "2024-10-15",
            firstUTC: "2024-10-15T00:00:00Z",
            lastUTC: "2024-10-15T23:59:59Z",
            temperature: TemperatureData(average: -62.3, minimum: -96.9, maximum: -15.9, count: 177556),
            pressure: PressureData(average: 750.6, minimum: 722.1, maximum: 768.8, count: 887776),
            windSpeed: WindSpeedData(average: 7.2, minimum: 1.1, maximum: 22.5, count: 88628),
            windDirection: nil,
            season: "fall",
            northernSeason: "early winter",
            southernSeason: "early summer",
            monthOrdinal: 10
        )
        
        // Then
        XCTAssertTrue(type(of: weather) is Identifiable.Type)
    }
    
    // MARK: - Enhanced Data Structure Tests
    
    func testTemperatureDataContainsAllFields() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            XCTAssertNotNil(weather.temperature.average)
            XCTAssertNotNil(weather.temperature.minimum)
            XCTAssertNotNil(weather.temperature.maximum)
            XCTAssertGreaterThan(weather.temperature.count, 0, 
                "Temperature sample count should be positive for sol \(weather.sol)")
        }
    }
    
    func testPressureDataContainsAllFields() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            XCTAssertNotNil(weather.pressure.average)
            XCTAssertNotNil(weather.pressure.minimum)
            XCTAssertNotNil(weather.pressure.maximum)
            XCTAssertGreaterThan(weather.pressure.count, 0,
                "Pressure sample count should be positive for sol \(weather.sol)")
        }
    }
    
    func testWindSpeedDataContainsAllFields() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            XCTAssertNotNil(weather.windSpeed.average)
            XCTAssertNotNil(weather.windSpeed.minimum)
            XCTAssertNotNil(weather.windSpeed.maximum)
            XCTAssertGreaterThan(weather.windSpeed.count, 0,
                "Wind speed sample count should be positive for sol \(weather.sol)")
        }
    }
    
    func testSeasonalDataIsComplete() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            XCTAssertFalse(weather.season.isEmpty, "Season should not be empty")
            XCTAssertFalse(weather.northernSeason.isEmpty, "Northern season should not be empty")
            XCTAssertFalse(weather.southernSeason.isEmpty, "Southern season should not be empty")
            XCTAssertGreaterThan(weather.monthOrdinal, 0, "Month ordinal should be positive")
            XCTAssertLessThanOrEqual(weather.monthOrdinal, 12, "Month ordinal should be <= 12")
        }
    }
    
    func testUTCTimestampsArePresent() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            XCTAssertFalse(weather.firstUTC.isEmpty, "First UTC timestamp should not be empty")
            XCTAssertFalse(weather.lastUTC.isEmpty, "Last UTC timestamp should not be empty")
        }
    }
    
    func testWindDirectionDataWhenPresent() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            if let windDir = weather.windDirection, let mostCommon = windDir.mostCommon {
                XCTAssertGreaterThanOrEqual(mostCommon.compassDegrees, 0.0)
                XCTAssertLessThan(mostCommon.compassDegrees, 360.0)
                XCTAssertFalse(mostCommon.compassPoint.isEmpty, "Compass point should not be empty")
                XCTAssertGreaterThan(mostCommon.count, 0, "Wind direction count should be positive")
            }
        }
    }
    
    func testBackwardCompatibilityProperties() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            // Test that convenience properties work correctly
            XCTAssertEqual(weather.minTemp, Int(weather.temperature.minimum))
            XCTAssertEqual(weather.maxTemp, Int(weather.temperature.maximum))
            XCTAssertEqual(weather.averageTemp, Int(weather.temperature.average))
            XCTAssertEqual(weather.averagePressure, Int(weather.pressure.average))
            XCTAssertEqual(weather.averageWindSpeed, Int(weather.windSpeed.average))
        }
    }
}
}
