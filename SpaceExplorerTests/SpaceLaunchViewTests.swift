import XCTest
import SwiftUI
@testable import SpaceExplorer

final class SpaceLaunchViewTests: XCTestCase {
    
    // MARK: - View Creation Tests
    
    func testSpaceLaunchViewCanBeCreated() {
        // Given & When
        let view = SpaceLaunchView()
        
        // Then
        XCTAssertNotNil(view)
    }
    
    func testSpaceLaunchViewDisplaysSampleData() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let launches = view.launches
        
        // Then
        XCTAssertEqual(launches.count, 6, "SpaceLaunchView should display 6 launches")
    }
    
    func testSpaceLaunchViewUsesSampleDataFromModel() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let expectedCount = SpaceLaunch.sampleData.count
        let actualCount = view.launches.count
        
        // Then
        XCTAssertEqual(actualCount, expectedCount, "SpaceLaunchView should use sample data from SpaceLaunch model")
    }
    
    // MARK: - Data Integrity Tests
    
    func testAllLaunchesHaveRequiredProperties() {
        // Given
        let view = SpaceLaunchView()
        
        // When & Then
        for launch in view.launches {
            XCTAssertFalse(launch.name.isEmpty, "Each launch should have a name")
            XCTAssertFalse(launch.agency.isEmpty, "Each launch should have an agency")
            XCTAssertFalse(launch.launchDate.isEmpty, "Each launch should have a launch date")
            XCTAssertFalse(launch.location.isEmpty, "Each launch should have a location")
            XCTAssertFalse(launch.missionType.isEmpty, "Each launch should have a mission type")
            XCTAssertFalse(launch.status.isEmpty, "Each launch should have a status")
        }
    }
    
    func testLaunchesHaveUniqueIDs() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let ids = view.launches.map { $0.id }
        let uniqueIds = Set(ids)
        
        // Then
        XCTAssertEqual(ids.count, uniqueIds.count, "All launches should have unique IDs")
    }
    
    // MARK: - Content Validation Tests
    
    func testSpaceXLaunchesAreDisplayed() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let spaceXLaunches = view.launches.filter { $0.agency == "SpaceX" }
        
        // Then
        XCTAssertGreaterThan(spaceXLaunches.count, 0, "SpaceX launches should be displayed")
    }
    
    func testNASALaunchesAreDisplayed() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let nasaLaunches = view.launches.filter { $0.agency == "NASA" }
        
        // Then
        XCTAssertGreaterThan(nasaLaunches.count, 0, "NASA launches should be displayed")
    }
    
    func testArtemisIIIsDisplayed() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let artemis = view.launches.first { $0.name.contains("Artemis II") }
        
        // Then
        XCTAssertNotNil(artemis, "Artemis II should be displayed")
        XCTAssertEqual(artemis?.agency, "NASA")
    }
    
    func testChandrayaan3IsDisplayed() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let chandrayaan = view.launches.first { $0.name.contains("Chandrayaan-3") }
        
        // Then
        XCTAssertNotNil(chandrayaan, "Chandrayaan-3 should be displayed")
        XCTAssertEqual(chandrayaan?.agency, "ISRO")
    }
    
    // MARK: - Status Tests
    
    func testScheduledLaunchesAreDisplayed() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let scheduledLaunches = view.launches.filter { $0.status == "Scheduled" }
        
        // Then
        XCTAssertGreaterThan(scheduledLaunches.count, 0, "Scheduled launches should be displayed")
    }
    
    func testLaunchedMissionsAreDisplayed() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let launchedMissions = view.launches.filter { $0.status == "Launched" }
        
        // Then
        XCTAssertGreaterThan(launchedMissions.count, 0, "Launched missions should be displayed")
    }
    
    func testStatusColorForScheduled() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let color = view.statusColor(for: "Scheduled")
        
        // Then
        XCTAssertEqual(color, .blue, "Scheduled status should have blue color")
    }
    
    func testStatusColorForLaunched() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let color = view.statusColor(for: "Launched")
        
        // Then
        XCTAssertEqual(color, .green, "Launched status should have green color")
    }
    
    func testStatusColorForUnknown() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let color = view.statusColor(for: "Unknown")
        
        // Then
        XCTAssertEqual(color, .gray, "Unknown status should have gray color")
    }
    
    // MARK: - Multiple Agency Tests
    
    func testMultipleAgenciesAreRepresented() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let agencies = Set(view.launches.map { $0.agency })
        
        // Then
        XCTAssertGreaterThan(agencies.count, 2, "Multiple space agencies should be represented")
    }
    
    func testBlueOriginIsDisplayed() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let blueOriginLaunches = view.launches.filter { $0.agency == "Blue Origin" }
        
        // Then
        XCTAssertGreaterThan(blueOriginLaunches.count, 0, "Blue Origin launches should be displayed")
    }
    
    func testESAIsDisplayed() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let esaLaunches = view.launches.filter { $0.agency == "ESA" }
        
        // Then
        XCTAssertGreaterThan(esaLaunches.count, 0, "ESA launches should be displayed")
    }
    
    func testISROIsDisplayed() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let isroLaunches = view.launches.filter { $0.agency == "ISRO" }
        
        // Then
        XCTAssertGreaterThan(isroLaunches.count, 0, "ISRO launches should be displayed")
    }
    
    // MARK: - Navigation Tests
    
    func testSpaceLaunchViewBodyIsNotNil() {
        // Given
        let view = SpaceLaunchView()
        
        // When
        let body = view.body
        
        // Then
        XCTAssertNotNil(body, "SpaceLaunchView body should not be nil")
    }
}
