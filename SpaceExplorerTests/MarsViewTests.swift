import XCTest
import SwiftUI
@testable import SpaceExplorer

final class MarsViewTests: XCTestCase {
    
    // MARK: - View Creation Tests
    
    func testMarsViewCanBeCreated() {
        // Given & When
        let view = MarsView()
        
        // Then
        XCTAssertNotNil(view)
    }
    
    func testMarsViewDisplaysSampleData() {
        // Given
        let view = MarsView()
        
        // When
        let weatherData = view.weatherData
        
        // Then
        XCTAssertEqual(weatherData.count, 5, "MarsView should display 5 weather entries")
    }
    
    func testMarsViewUsesSampleDataFromModel() {
        // Given
        let view = MarsView()
        
        // When
        let expectedCount = MarsWeather.sampleData.count
        let actualCount = view.weatherData.count
        
        // Then
        XCTAssertEqual(actualCount, expectedCount, "MarsView should use sample data from MarsWeather model")
    }
    
    // MARK: - Data Integrity Tests
    
    func testAllWeatherEntriesHaveRequiredProperties() {
        // Given
        let view = MarsView()
        
        // When & Then
        for weather in view.weatherData {
            XCTAssertGreaterThan(weather.sol, 0, "Each weather entry should have a valid sol")
            XCTAssertFalse(weather.earthDate.isEmpty, "Each weather entry should have an earth date")
            XCTAssertLessThan(weather.minTemp, weather.maxTemp, "Min temp should be less than max temp")
            XCTAssertGreaterThan(weather.pressure, 0, "Each weather entry should have a valid pressure")
            XCTAssertGreaterThanOrEqual(weather.windSpeed, 0, "Wind speed should be non-negative")
            XCTAssertFalse(weather.season.isEmpty, "Each weather entry should have a season")
        }
    }
    
    func testWeatherEntriesHaveUniqueIDs() {
        // Given
        let view = MarsView()
        
        // When
        let ids = view.weatherData.map { $0.id }
        let uniqueIds = Set(ids)
        
        // Then
        XCTAssertEqual(ids.count, uniqueIds.count, "All weather entries should have unique IDs")
    }
    
    // MARK: - Content Validation Tests
    
    func testSol4012IsDisplayed() {
        // Given
        let view = MarsView()
        
        // When
        let sol4012 = view.weatherData.first { $0.sol == 4012 }
        
        // Then
        XCTAssertNotNil(sol4012, "Sol 4012 should be in the displayed weather data")
        XCTAssertEqual(sol4012?.earthDate, "2024-10-15")
    }
    
    func testSol4011IsDisplayed() {
        // Given
        let view = MarsView()
        
        // When
        let sol4011 = view.weatherData.first { $0.sol == 4011 }
        
        // Then
        XCTAssertNotNil(sol4011, "Sol 4011 should be in the displayed weather data")
    }
    
    func testWeatherDataIsInDescendingOrder() {
        // Given
        let view = MarsView()
        
        // When & Then
        for i in 0..<(view.weatherData.count - 1) {
            XCTAssertGreaterThan(view.weatherData[i].sol, view.weatherData[i + 1].sol,
                "Weather data should be in descending order by sol")
        }
    }
    
    // MARK: - Temperature Range Tests
    
    func testAllTemperaturesAreRealistic() {
        // Given
        let view = MarsView()
        
        // When & Then
        for weather in view.weatherData {
            // Mars temperatures typically range from -125°C to 20°C
            XCTAssertGreaterThanOrEqual(weather.minTemp, -125,
                "Min temperature should be within realistic range for sol \(weather.sol)")
            XCTAssertLessThanOrEqual(weather.maxTemp, 20,
                "Max temperature should be within realistic range for sol \(weather.sol)")
        }
    }
    
    // MARK: - Atmospheric Data Tests
    
    func testAllPressureValuesAreRealistic() {
        // Given
        let view = MarsView()
        
        // When & Then
        for weather in view.weatherData {
            // Mars atmospheric pressure typically ranges from 400 to 870 Pascals
            XCTAssertGreaterThanOrEqual(weather.pressure, 400,
                "Pressure should be within realistic range for sol \(weather.sol)")
            XCTAssertLessThanOrEqual(weather.pressure, 870,
                "Pressure should be within realistic range for sol \(weather.sol)")
        }
    }
    
    func testAllWindSpeedsAreRealistic() {
        // Given
        let view = MarsView()
        
        // When & Then
        for weather in view.weatherData {
            // Mars wind speeds typically range from 0 to 60 m/s
            XCTAssertGreaterThanOrEqual(weather.windSpeed, 0,
                "Wind speed should be non-negative for sol \(weather.sol)")
            XCTAssertLessThanOrEqual(weather.windSpeed, 60,
                "Wind speed should be within realistic range for sol \(weather.sol)")
        }
    }
    
    // MARK: - Season Tests
    
    func testAllEntriesHaveSeason() {
        // Given
        let view = MarsView()
        
        // When & Then
        for weather in view.weatherData {
            XCTAssertFalse(weather.season.isEmpty,
                "Each weather entry should have a season for sol \(weather.sol)")
        }
    }
    
    // MARK: - Navigation Tests
    
    func testMarsViewBodyIsNotNil() {
        // Given
        let view = MarsView()
        
        // When
        let body = view.body
        
        // Then
        XCTAssertNotNil(body, "MarsView body should not be nil")
    }
}
