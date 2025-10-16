import XCTest
@testable import SpaceExplorer

final class SpaceLaunchTests: XCTestCase {
    
    // MARK: - Model Creation Tests
    
    func testSpaceLaunchInitialization() {
        // Given
        let name = "Falcon 9 - Starlink Group 6-25"
        let agency = "SpaceX"
        let launchDate = "2024-10-20"
        let location = "Cape Canaveral, FL"
        let missionType = "Communications"
        let status = "Scheduled"
        
        // When
        let launch = SpaceLaunch(
            name: name,
            agency: agency,
            launchDate: launchDate,
            location: location,
            missionType: missionType,
            status: status
        )
        
        // Then
        XCTAssertEqual(launch.name, name)
        XCTAssertEqual(launch.agency, agency)
        XCTAssertEqual(launch.launchDate, launchDate)
        XCTAssertEqual(launch.location, location)
        XCTAssertEqual(launch.missionType, missionType)
        XCTAssertEqual(launch.status, status)
        XCTAssertNotNil(launch.id)
    }
    
    func testSpaceLaunchHasUniqueID() {
        // Given & When
        let launch1 = SpaceLaunch(
            name: "Launch 1",
            agency: "NASA",
            launchDate: "2024-10-20",
            location: "Kennedy Space Center",
            missionType: "Crewed",
            status: "Scheduled"
        )
        let launch2 = SpaceLaunch(
            name: "Launch 2",
            agency: "SpaceX",
            launchDate: "2024-10-21",
            location: "Cape Canaveral",
            missionType: "Cargo",
            status: "Launched"
        )
        
        // Then
        XCTAssertNotEqual(launch1.id, launch2.id)
    }
    
    // MARK: - Sample Data Tests
    
    func testSampleDataIsNotEmpty() {
        // Given & When
        let sampleData = SpaceLaunch.sampleData
        
        // Then
        XCTAssertFalse(sampleData.isEmpty, "Sample data should not be empty")
    }
    
    func testSampleDataHasExpectedCount() {
        // Given & When
        let sampleData = SpaceLaunch.sampleData
        
        // Then
        XCTAssertEqual(sampleData.count, 6, "Sample data should contain 6 launches")
    }
    
    func testSampleDataHasValidProperties() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        
        // When & Then
        for launch in sampleData {
            XCTAssertFalse(launch.name.isEmpty, "Name should not be empty")
            XCTAssertFalse(launch.agency.isEmpty, "Agency should not be empty")
            XCTAssertFalse(launch.launchDate.isEmpty, "Launch date should not be empty")
            XCTAssertFalse(launch.location.isEmpty, "Location should not be empty")
            XCTAssertFalse(launch.missionType.isEmpty, "Mission type should not be empty")
            XCTAssertFalse(launch.status.isEmpty, "Status should not be empty")
        }
    }
    
    // MARK: - Agency Tests
    
    func testSampleDataContainsSpaceX() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        
        // When
        let spaceXLaunches = sampleData.filter { $0.agency == "SpaceX" }
        
        // Then
        XCTAssertFalse(spaceXLaunches.isEmpty, "Sample data should contain SpaceX launches")
    }
    
    func testSampleDataContainsNASA() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        
        // When
        let nasaLaunches = sampleData.filter { $0.agency == "NASA" }
        
        // Then
        XCTAssertFalse(nasaLaunches.isEmpty, "Sample data should contain NASA launches")
    }
    
    func testSampleDataContainsMultipleAgencies() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        
        // When
        let agencies = Set(sampleData.map { $0.agency })
        
        // Then
        XCTAssertGreaterThan(agencies.count, 1, "Sample data should contain multiple agencies")
    }
    
    // MARK: - Status Tests
    
    func testSampleDataHasScheduledLaunches() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        
        // When
        let scheduledLaunches = sampleData.filter { $0.status == "Scheduled" }
        
        // Then
        XCTAssertFalse(scheduledLaunches.isEmpty, "Sample data should contain scheduled launches")
    }
    
    func testSampleDataHasLaunchedMissions() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        
        // When
        let launchedMissions = sampleData.filter { $0.status == "Launched" }
        
        // Then
        XCTAssertFalse(launchedMissions.isEmpty, "Sample data should contain launched missions")
    }
    
    func testStatusIsValidValue() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        let validStatuses = ["Scheduled", "Launched"]
        
        // When & Then
        for launch in sampleData {
            XCTAssertTrue(validStatuses.contains(launch.status),
                "Status '\(launch.status)' should be a valid status value")
        }
    }
    
    // MARK: - Mission Type Tests
    
    func testSampleDataHasVariousMissionTypes() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        
        // When
        let missionTypes = Set(sampleData.map { $0.missionType })
        
        // Then
        XCTAssertGreaterThan(missionTypes.count, 1, "Sample data should contain multiple mission types")
    }
    
    func testArtemisIIMissionExists() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        
        // When
        let artemis = sampleData.first { $0.name.contains("Artemis II") }
        
        // Then
        XCTAssertNotNil(artemis, "Sample data should contain Artemis II mission")
        XCTAssertEqual(artemis?.agency, "NASA")
        XCTAssertEqual(artemis?.status, "Scheduled")
    }
    
    func testChandrayaan3MissionExists() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        
        // When
        let chandrayaan = sampleData.first { $0.name.contains("Chandrayaan-3") }
        
        // Then
        XCTAssertNotNil(chandrayaan, "Sample data should contain Chandrayaan-3 mission")
        XCTAssertEqual(chandrayaan?.agency, "ISRO")
        XCTAssertEqual(chandrayaan?.status, "Launched")
    }
    
    // MARK: - Location Tests
    
    func testLaunchLocationsAreValid() {
        // Given
        let sampleData = SpaceLaunch.sampleData
        
        // When & Then
        for launch in sampleData {
            XCTAssertFalse(launch.location.isEmpty, "Location should not be empty for \(launch.name)")
            XCTAssertTrue(launch.location.contains(",") || launch.location.contains("Centre"),
                "Location should have a recognizable format for \(launch.name)")
        }
    }
    
    // MARK: - Identifiable Conformance Tests
    
    func testSpaceLaunchConformsToIdentifiable() {
        // Given
        let launch = SpaceLaunch(
            name: "Test",
            agency: "Test",
            launchDate: "2024-10-15",
            location: "Test",
            missionType: "Test",
            status: "Scheduled"
        )
        
        // Then
        XCTAssertTrue(type(of: launch) is Identifiable.Type)
    }
}
