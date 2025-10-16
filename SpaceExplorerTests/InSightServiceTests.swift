import XCTest
@testable import SpaceExplorer

final class InSightServiceTests: XCTestCase {
    
    // MARK: - Service Tests
    
    func testInSightServiceIsSingleton() {
        // Given & When
        let instance1 = InSightService.shared
        let instance2 = InSightService.shared
        
        // Then
        XCTAssertTrue(instance1 === instance2, "InSightService should be a singleton")
    }
    
    func testParseMarsWeatherDataReturnsEmptyArrayForInvalidData() {
        // Given
        let invalidData = "invalid json".data(using: .utf8)!
        
        // When
        let result = InSightService.shared.parseMarsWeatherData(from: invalidData)
        
        // Then
        XCTAssertEqual(result.count, 0, "Should return empty array for invalid data")
    }
    
    func testParseMarsWeatherDataWithValidStructure() {
        // Given
        let json = """
        {
            "sol_keys": ["4012", "4011"],
            "4012": {
                "First_UTC": "2024-10-15T00:00:00Z",
                "Last_UTC": "2024-10-15T23:59:59Z",
                "Season": "Month 6",
                "AT": {
                    "av": -18.5,
                    "ct": 100
                },
                "PRE": {
                    "av": 750.2,
                    "ct": 100
                },
                "HWS": {
                    "av": 12.3,
                    "ct": 100
                }
            },
            "4011": {
                "First_UTC": "2024-10-14T00:00:00Z",
                "Last_UTC": "2024-10-14T23:59:59Z",
                "Season": "Month 6"
            }
        }
        """
        let data = json.data(using: .utf8)!
        
        // When
        let result = InSightService.shared.parseMarsWeatherData(from: data)
        
        // Then
        XCTAssertGreaterThan(result.count, 0, "Should parse valid data")
        
        if let firstWeather = result.first {
            XCTAssertEqual(firstWeather.sol, 4012)
            XCTAssertEqual(firstWeather.earthDate, "2024-10-15")
            XCTAssertEqual(firstWeather.season, "Month 6")
            XCTAssertEqual(firstWeather.pressure, 750)
            XCTAssertEqual(firstWeather.windSpeed, 12)
        }
    }
    
    func testExtractDateFromUTCString() {
        // This is a private method, so we test it indirectly through parseMarsWeatherData
        // Given
        let json = """
        {
            "sol_keys": ["4012"],
            "4012": {
                "First_UTC": "2024-10-15T12:30:45Z",
                "Season": "Month 6"
            }
        }
        """
        let data = json.data(using: .utf8)!
        
        // When
        let result = InSightService.shared.parseMarsWeatherData(from: data)
        
        // Then
        if let weather = result.first {
            XCTAssertEqual(weather.earthDate, "2024-10-15", "Should extract date correctly from UTC string")
        }
    }
    
    func testParseMarsWeatherDataLimitsToFiveSols() {
        // Given - Create JSON with 10 sols
        var solKeys: [String] = []
        var solData: [String: Any] = [:]
        
        for i in 4020..<4030 {
            solKeys.append("\(i)")
            solData["\(i)"] = [
                "First_UTC": "2024-10-15T00:00:00Z",
                "Season": "Month 6"
            ]
        }
        solData["sol_keys"] = solKeys
        
        let jsonData = try! JSONSerialization.data(withJSONObject: solData)
        
        // When
        let result = InSightService.shared.parseMarsWeatherData(from: jsonData)
        
        // Then
        XCTAssertLessThanOrEqual(result.count, 5, "Should limit to 5 sols maximum")
    }
    
    func testParseMarsWeatherDataHandlesMissingTemperature() {
        // Given
        let json = """
        {
            "sol_keys": ["4012"],
            "4012": {
                "First_UTC": "2024-10-15T00:00:00Z",
                "Season": "Month 6"
            }
        }
        """
        let data = json.data(using: .utf8)!
        
        // When
        let result = InSightService.shared.parseMarsWeatherData(from: data)
        
        // Then
        if let weather = result.first {
            // Should use default values when temperature data is missing
            XCTAssertNotEqual(weather.minTemp, 0)
            XCTAssertNotEqual(weather.maxTemp, 0)
        }
    }
}
