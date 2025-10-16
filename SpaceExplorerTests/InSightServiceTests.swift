import XCTest
import Combine
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
            "sol_keys": ["675", "674"],
            "675": {
                "First_UTC": "2020-10-19T18:32:20Z",
                "Last_UTC": "2020-10-20T19:11:55Z",
                "Season": "fall",
                "Northern_season": "early winter",
                "Southern_season": "early summer",
                "Month_ordinal": 10,
                "AT": {
                    "av": -62.314,
                    "mn": -96.872,
                    "mx": -15.908,
                    "ct": 177556
                },
                "PRE": {
                    "av": 750.563,
                    "mn": 722.0901,
                    "mx": 768.791,
                    "ct": 887776
                },
                "HWS": {
                    "av": 7.233,
                    "mn": 1.051,
                    "mx": 22.455,
                    "ct": 88628
                },
                "WD": {
                    "most_common": {
                        "compass_degrees": 292.5,
                        "compass_point": "WNW",
                        "compass_right": -0.923879532511,
                        "compass_up": 0.382683432365,
                        "ct": 30283
                    }
                }
            },
            "674": {
                "First_UTC": "2020-10-18T18:32:20Z",
                "Last_UTC": "2020-10-19T19:11:55Z",
                "Season": "fall"
            }
        }
        """
        let data = json.data(using: .utf8)!
        
        // When
        let result = InSightService.shared.parseMarsWeatherData(from: data)
        
        // Then
        XCTAssertGreaterThan(result.count, 0, "Should parse valid data")
        
        if let firstWeather = result.first {
            XCTAssertEqual(firstWeather.sol, 675)
            XCTAssertEqual(firstWeather.earthDate, "2020-10-19")
            XCTAssertEqual(firstWeather.season, "fall")
            XCTAssertEqual(firstWeather.northernSeason, "early winter")
            XCTAssertEqual(firstWeather.southernSeason, "early summer")
            XCTAssertEqual(firstWeather.monthOrdinal, 10)
            
            // Test temperature data
            XCTAssertEqual(firstWeather.temperature.average, -62.314, accuracy: 0.01)
            XCTAssertEqual(firstWeather.temperature.minimum, -96.872, accuracy: 0.01)
            XCTAssertEqual(firstWeather.temperature.maximum, -15.908, accuracy: 0.01)
            XCTAssertEqual(firstWeather.temperature.count, 177556)
            
            // Test pressure data
            XCTAssertEqual(firstWeather.pressure.average, 750.563, accuracy: 0.01)
            XCTAssertEqual(firstWeather.pressure.minimum, 722.0901, accuracy: 0.01)
            XCTAssertEqual(firstWeather.pressure.maximum, 768.791, accuracy: 0.01)
            
            // Test wind speed data
            XCTAssertEqual(firstWeather.windSpeed.average, 7.233, accuracy: 0.01)
            XCTAssertEqual(firstWeather.windSpeed.minimum, 1.051, accuracy: 0.01)
            XCTAssertEqual(firstWeather.windSpeed.maximum, 22.455, accuracy: 0.01)
            
            // Test wind direction
            XCTAssertNotNil(firstWeather.windDirection)
            if let windDir = firstWeather.windDirection, let mostCommon = windDir.mostCommon {
                XCTAssertEqual(mostCommon.compassDegrees, 292.5, accuracy: 0.01)
                XCTAssertEqual(mostCommon.compassPoint, "WNW")
                XCTAssertEqual(mostCommon.count, 30283)
            }
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
                "Last_UTC": "2024-10-15T23:59:59Z",
                "Season": "fall",
                "Northern_season": "early winter",
                "Southern_season": "early summer",
                "Month_ordinal": 10
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
                "Last_UTC": "2024-10-15T23:59:59Z",
                "Season": "fall",
                "Northern_season": "early winter",
                "Southern_season": "early summer",
                "Month_ordinal": 10
            ]
        }
        solData["sol_keys"] = solKeys
        
        let jsonData = try! JSONSerialization.data(withJSONObject: solData)
        
        // When
        let result = InSightService.shared.parseMarsWeatherData(from: jsonData)
        
        // Then
        XCTAssertLessThanOrEqual(result.count, 5, "Should limit to 5 sols maximum")
    }
    
    func testParseMarsWeatherDataHandlesMissingData() {
        // Given
        let json = """
        {
            "sol_keys": ["4012"],
            "4012": {
                "First_UTC": "2024-10-15T00:00:00Z",
                "Last_UTC": "2024-10-15T23:59:59Z",
                "Season": "fall",
                "Northern_season": "early winter",
                "Southern_season": "early summer",
                "Month_ordinal": 10
            }
        }
        """
        let data = json.data(using: .utf8)!
        
        // When
        let result = InSightService.shared.parseMarsWeatherData(from: data)
        
        // Then
        if let weather = result.first {
            // Should use default values when detailed data is missing
            XCTAssertNotNil(weather.temperature)
            XCTAssertNotNil(weather.pressure)
            XCTAssertNotNil(weather.windSpeed)
        }
    }
    
    // MARK: - Combine Publisher Tests
    
    func testFetchMarsWeatherPublisherReturnsPublisher() {
        // Given & When
        let publisher = InSightService.shared.fetchMarsWeatherPublisher()
        
        // Then
        XCTAssertNotNil(publisher, "Should return a valid publisher")
    }
    
    func testFetchMarsWeatherPublisherCanBeCancelled() {
        // Given
        let expectation = XCTestExpectation(description: "Publisher should be cancellable")
        var cancellables = Set<AnyCancellable>()
        
        // When
        let cancellable = InSightService.shared.fetchMarsWeatherPublisher()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
        
        cancellable.store(in: &cancellables)
        cancellables.removeAll()
        
        // Then
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }
}
