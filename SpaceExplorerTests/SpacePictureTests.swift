import XCTest
@testable import SpaceExplorer

final class SpacePictureTests: XCTestCase {
    
    // MARK: - Model Creation Tests
    
    func testSpacePictureInitialization() {
        // Given
        let title = "Test Picture"
        let description = "Test Description"
        let imageName = "star.fill"
        let date = "2024-10-15"
        
        // When
        let picture = SpacePicture(
            title: title,
            description: description,
            imageName: imageName,
            date: date
        )
        
        // Then
        XCTAssertEqual(picture.title, title)
        XCTAssertEqual(picture.description, description)
        XCTAssertEqual(picture.imageName, imageName)
        XCTAssertEqual(picture.date, date)
        XCTAssertNotNil(picture.id)
    }
    
    func testSpacePictureHasUniqueID() {
        // Given & When
        let picture1 = SpacePicture(
            title: "Picture 1",
            description: "Description 1",
            imageName: "star.fill",
            date: "2024-10-15"
        )
        let picture2 = SpacePicture(
            title: "Picture 2",
            description: "Description 2",
            imageName: "sparkles",
            date: "2024-10-16"
        )
        
        // Then
        XCTAssertNotEqual(picture1.id, picture2.id)
    }
    
    // MARK: - Sample Data Tests
    
    func testSampleDataIsNotEmpty() {
        // Given & When
        let sampleData = SpacePicture.sampleData
        
        // Then
        XCTAssertFalse(sampleData.isEmpty, "Sample data should not be empty")
    }
    
    func testSampleDataHasExpectedCount() {
        // Given & When
        let sampleData = SpacePicture.sampleData
        
        // Then
        XCTAssertEqual(sampleData.count, 5, "Sample data should contain 5 pictures")
    }
    
    func testSampleDataHasValidProperties() {
        // Given
        let sampleData = SpacePicture.sampleData
        
        // When & Then
        for picture in sampleData {
            XCTAssertFalse(picture.title.isEmpty, "Title should not be empty")
            XCTAssertFalse(picture.description.isEmpty, "Description should not be empty")
            XCTAssertFalse(picture.imageName.isEmpty, "Image name should not be empty")
            XCTAssertFalse(picture.date.isEmpty, "Date should not be empty")
        }
    }
    
    func testSampleDataContainsAndromedaGalaxy() {
        // Given
        let sampleData = SpacePicture.sampleData
        
        // When
        let andromedaGalaxy = sampleData.first { $0.title == "Andromeda Galaxy" }
        
        // Then
        XCTAssertNotNil(andromedaGalaxy, "Sample data should contain Andromeda Galaxy")
        XCTAssertEqual(andromedaGalaxy?.imageName, "star.fill")
    }
    
    func testSampleDataContainsEagleNebula() {
        // Given
        let sampleData = SpacePicture.sampleData
        
        // When
        let eagleNebula = sampleData.first { $0.title == "Eagle Nebula" }
        
        // Then
        XCTAssertNotNil(eagleNebula, "Sample data should contain Eagle Nebula")
        XCTAssertEqual(eagleNebula?.imageName, "sparkles")
    }
    
    // MARK: - Identifiable Conformance Tests
    
    func testSpacePictureConformsToIdentifiable() {
        // Given
        let picture = SpacePicture(
            title: "Test",
            description: "Test",
            imageName: "star.fill",
            date: "2024-10-15"
        )
        
        // Then
        XCTAssertTrue(type(of: picture) is Identifiable.Type)
    }
}
