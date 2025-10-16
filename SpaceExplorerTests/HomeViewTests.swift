import XCTest
import SwiftUI
import ViewInspector
@testable import SpaceExplorer

final class HomeViewTests: XCTestCase {
    
    // MARK: - View Creation Tests
    
    func testHomeViewCanBeCreated() {
        // Given & When
        let view = HomeView()
        
        // Then
        XCTAssertNotNil(view)
    }
    
    func testHomeViewDisplaysSampleData() {
        // Given
        let view = HomeView()
        
        // When
        let pictures = view.pictures
        
        // Then
        XCTAssertEqual(pictures.count, 5, "HomeView should display 5 pictures")
    }
    
    func testHomeViewUsesSampleDataFromModel() {
        // Given
        let view = HomeView()
        
        // When
        let expectedCount = SpacePicture.sampleData.count
        let actualCount = view.pictures.count
        
        // Then
        XCTAssertEqual(actualCount, expectedCount, "HomeView should use sample data from SpacePicture model")
    }
    
    // MARK: - Data Integrity Tests
    
    func testAllPicturesHaveRequiredProperties() {
        // Given
        let view = HomeView()
        
        // When & Then
        for picture in view.pictures {
            XCTAssertFalse(picture.title.isEmpty, "Each picture should have a title")
            XCTAssertFalse(picture.description.isEmpty, "Each picture should have a description")
            XCTAssertFalse(picture.imageName.isEmpty, "Each picture should have an image name")
            XCTAssertFalse(picture.date.isEmpty, "Each picture should have a date")
        }
    }
    
    func testPicturesHaveUniqueIDs() {
        // Given
        let view = HomeView()
        
        // When
        let ids = view.pictures.map { $0.id }
        let uniqueIds = Set(ids)
        
        // Then
        XCTAssertEqual(ids.count, uniqueIds.count, "All pictures should have unique IDs")
    }
    
    // MARK: - Content Validation Tests
    
    func testAndromedaGalaxyIsDisplayed() {
        // Given
        let view = HomeView()
        
        // When
        let andromeda = view.pictures.first { $0.title == "Andromeda Galaxy" }
        
        // Then
        XCTAssertNotNil(andromeda, "Andromeda Galaxy should be in the displayed pictures")
    }
    
    func testEagleNebulaIsDisplayed() {
        // Given
        let view = HomeView()
        
        // When
        let eagle = view.pictures.first { $0.title == "Eagle Nebula" }
        
        // Then
        XCTAssertNotNil(eagle, "Eagle Nebula should be in the displayed pictures")
    }
    
    func testHubbleDeepFieldIsDisplayed() {
        // Given
        let view = HomeView()
        
        // When
        let hubble = view.pictures.first { $0.title == "Hubble Deep Field" }
        
        // Then
        XCTAssertNotNil(hubble, "Hubble Deep Field should be in the displayed pictures")
    }
    
    func testJupitersGreatRedSpotIsDisplayed() {
        // Given
        let view = HomeView()
        
        // When
        let jupiter = view.pictures.first { $0.title == "Jupiter's Great Red Spot" }
        
        // Then
        XCTAssertNotNil(jupiter, "Jupiter's Great Red Spot should be in the displayed pictures")
    }
    
    func testSaturnsRingsIsDisplayed() {
        // Given
        let view = HomeView()
        
        // When
        let saturn = view.pictures.first { $0.title == "Saturn's Rings" }
        
        // Then
        XCTAssertNotNil(saturn, "Saturn's Rings should be in the displayed pictures")
    }
    
    // MARK: - Navigation Tests
    
    func testHomeViewBodyIsNotNil() {
        // Given
        let view = HomeView()
        
        // When
        let body = view.body
        
        // Then
        XCTAssertNotNil(body, "HomeView body should not be nil")
    }
}
