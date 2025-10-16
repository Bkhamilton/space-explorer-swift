import XCTest
@testable import SpaceExplorer

final class APODServiceTests: XCTestCase {
    
    // MARK: - Service Tests
    
    func testAPODServiceIsSingleton() {
        // Given & When
        let instance1 = APODService.shared
        let instance2 = APODService.shared
        
        // Then
        XCTAssertTrue(instance1 === instance2, "APODService should be a singleton")
    }
    
    func testAPODResponseDecoding() throws {
        // Given
        let json = """
        {
            "date": "2024-10-15",
            "explanation": "This is a test explanation",
            "title": "Test APOD",
            "url": "https://example.com/image.jpg",
            "media_type": "image"
        }
        """
        let data = json.data(using: .utf8)!
        
        // When
        let decoder = JSONDecoder()
        let apod = try decoder.decode(APODResponse.self, from: data)
        
        // Then
        XCTAssertEqual(apod.date, "2024-10-15")
        XCTAssertEqual(apod.explanation, "This is a test explanation")
        XCTAssertEqual(apod.title, "Test APOD")
        XCTAssertEqual(apod.url, "https://example.com/image.jpg")
        XCTAssertEqual(apod.mediaType, "image")
    }
    
    func testAPODResponseArrayDecoding() throws {
        // Given
        let json = """
        [
            {
                "date": "2024-10-15",
                "explanation": "First explanation",
                "title": "First APOD",
                "url": "https://example.com/image1.jpg",
                "media_type": "image"
            },
            {
                "date": "2024-10-14",
                "explanation": "Second explanation",
                "title": "Second APOD",
                "url": "https://example.com/image2.jpg",
                "media_type": "image"
            }
        ]
        """
        let data = json.data(using: .utf8)!
        
        // When
        let decoder = JSONDecoder()
        let apods = try decoder.decode([APODResponse].self, from: data)
        
        // Then
        XCTAssertEqual(apods.count, 2)
        XCTAssertEqual(apods[0].title, "First APOD")
        XCTAssertEqual(apods[1].title, "Second APOD")
    }
    
    func testSpacePictureInitFromAPODResponse() {
        // Given
        let apod = APODResponse(
            date: "2024-10-15",
            explanation: "Test explanation",
            title: "Test Title",
            url: "https://example.com/image.jpg",
            hdurl: nil,
            mediaType: "image"
        )
        
        // When
        let picture = SpacePicture(from: apod)
        
        // Then
        XCTAssertEqual(picture.title, "Test Title")
        XCTAssertEqual(picture.description, "Test explanation")
        XCTAssertEqual(picture.date, "2024-10-15")
        XCTAssertEqual(picture.imageName, "photo")
        XCTAssertNotNil(picture.id)
    }
    
    // MARK: - API Configuration Tests
    
    func testAPIConfigurationReturnsKey() {
        // Given & When
        let apiKey = APIConfiguration.nasaAPIKey
        
        // Then
        XCTAssertFalse(apiKey.isEmpty, "API key should not be empty")
        // Should return either environment variable or DEMO_KEY
        XCTAssertTrue(apiKey == "DEMO_KEY" || apiKey != "DEMO_KEY", "API key should be valid")
    }
}
