import XCTest
@testable import SpaceExplorer

final class MarsWeatherTests: XCTestCase {
    
    // MARK: - Model Creation Tests
    
    func testMarsWeatherInitialization() {
        // Given
        let sol = 4012
        let earthDate = "2024-10-15"
        let minTemp = -89
        let maxTemp = -18
        let pressure = 750
        let windSpeed = 12
        let season = "Month 6"
        
        // When
        let weather = MarsWeather(
            sol: sol,
            earthDate: earthDate,
            minTemp: minTemp,
            maxTemp: maxTemp,
            pressure: pressure,
            windSpeed: windSpeed,
            season: season
        )
        
        // Then
        XCTAssertEqual(weather.sol, sol)
        XCTAssertEqual(weather.earthDate, earthDate)
        XCTAssertEqual(weather.minTemp, minTemp)
        XCTAssertEqual(weather.maxTemp, maxTemp)
        XCTAssertEqual(weather.pressure, pressure)
        XCTAssertEqual(weather.windSpeed, windSpeed)
        XCTAssertEqual(weather.season, season)
        XCTAssertNotNil(weather.id)
    }
    
    func testMarsWeatherHasUniqueID() {
        // Given & When
        let weather1 = MarsWeather(
            sol: 4012,
            earthDate: "2024-10-15",
            minTemp: -89,
            maxTemp: -18,
            pressure: 750,
            windSpeed: 12,
            season: "Month 6"
        )
        let weather2 = MarsWeather(
            sol: 4013,
            earthDate: "2024-10-16",
            minTemp: -90,
            maxTemp: -20,
            pressure: 751,
            windSpeed: 13,
            season: "Month 6"
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
            XCTAssertLessThan(weather.minTemp, weather.maxTemp, 
                "Min temperature should be less than max temperature for sol \(weather.sol)")
        }
    }
    
    func testMarsTemperaturesAreRealistic() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            // Mars temperatures typically range from -125°C to 20°C
            XCTAssertGreaterThanOrEqual(weather.minTemp, -125, 
                "Min temperature should be within realistic Mars range for sol \(weather.sol)")
            XCTAssertLessThanOrEqual(weather.maxTemp, 20, 
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
            XCTAssertGreaterThan(weather.pressure, 0, "Pressure should be positive")
            XCTAssertGreaterThanOrEqual(weather.windSpeed, 0, "Wind speed should be non-negative")
            XCTAssertFalse(weather.season.isEmpty, "Season should not be empty")
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
            XCTAssertGreaterThanOrEqual(weather.pressure, 400, 
                "Pressure should be within realistic Mars range for sol \(weather.sol)")
            XCTAssertLessThanOrEqual(weather.pressure, 870, 
                "Pressure should be within realistic Mars range for sol \(weather.sol)")
        }
    }
    
    func testWindSpeedIsRealistic() {
        // Given
        let sampleData = MarsWeather.sampleData
        
        // When & Then
        for weather in sampleData {
            // Mars wind speeds typically range from 0 to 60 m/s
            XCTAssertGreaterThanOrEqual(weather.windSpeed, 0, 
                "Wind speed should be non-negative for sol \(weather.sol)")
            XCTAssertLessThanOrEqual(weather.windSpeed, 60, 
                "Wind speed should be within realistic Mars range for sol \(weather.sol)")
        }
    }
    
    // MARK: - Identifiable Conformance Tests
    
    func testMarsWeatherConformsToIdentifiable() {
        // Given
        let weather = MarsWeather(
            sol: 4012,
            earthDate: "2024-10-15",
            minTemp: -89,
            maxTemp: -18,
            pressure: 750,
            windSpeed: 12,
            season: "Month 6"
        )
        
        // Then
        XCTAssertTrue(type(of: weather) is Identifiable.Type)
    }
}
