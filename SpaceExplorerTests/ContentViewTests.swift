import XCTest
import SwiftUI
@testable import SpaceExplorer

final class ContentViewTests: XCTestCase {
    
    // MARK: - View Creation Tests
    
    func testContentViewCanBeCreated() {
        // Given & When
        let view = ContentView()
        
        // Then
        XCTAssertNotNil(view)
    }
    
    func testContentViewBodyIsNotNil() {
        // Given
        let view = ContentView()
        
        // When
        let body = view.body
        
        // Then
        XCTAssertNotNil(body, "ContentView body should not be nil")
    }
}
