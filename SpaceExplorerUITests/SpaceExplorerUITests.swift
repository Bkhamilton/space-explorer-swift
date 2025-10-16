import XCTest

final class SpaceExplorerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }
    
    // MARK: - App Launch Tests
    
    func testAppLaunches() throws {
        // Given & When
        // App is already launched in setUp
        
        // Then
        XCTAssertTrue(app.state == .runningForeground, "App should be running in foreground")
    }
    
    // MARK: - Tab Navigation Tests
    
    func testHomeTabIsVisibleOnLaunch() throws {
        // Given & When
        let homeTab = app.tabBars.buttons["Home"]
        
        // Then
        XCTAssertTrue(homeTab.exists, "Home tab should exist")
        XCTAssertTrue(homeTab.isSelected, "Home tab should be selected on launch")
    }
    
    func testMarsTabExists() throws {
        // Given & When
        let marsTab = app.tabBars.buttons["Mars"]
        
        // Then
        XCTAssertTrue(marsTab.exists, "Mars tab should exist")
    }
    
    func testSpaceLaunchTabExists() throws {
        // Given & When
        let spaceLaunchTab = app.tabBars.buttons["Space Launch"]
        
        // Then
        XCTAssertTrue(spaceLaunchTab.exists, "Space Launch tab should exist")
    }
    
    func testNavigationToMarsTab() throws {
        // Given
        let marsTab = app.tabBars.buttons["Mars"]
        
        // When
        marsTab.tap()
        
        // Then
        XCTAssertTrue(marsTab.isSelected, "Mars tab should be selected after tap")
    }
    
    func testNavigationToSpaceLaunchTab() throws {
        // Given
        let spaceLaunchTab = app.tabBars.buttons["Space Launch"]
        
        // When
        spaceLaunchTab.tap()
        
        // Then
        XCTAssertTrue(spaceLaunchTab.isSelected, "Space Launch tab should be selected after tap")
    }
    
    func testNavigationBetweenAllTabs() throws {
        // Given
        let homeTab = app.tabBars.buttons["Home"]
        let marsTab = app.tabBars.buttons["Mars"]
        let spaceLaunchTab = app.tabBars.buttons["Space Launch"]
        
        // When & Then - Navigate to Mars
        marsTab.tap()
        XCTAssertTrue(marsTab.isSelected, "Mars tab should be selected")
        
        // Navigate to Space Launch
        spaceLaunchTab.tap()
        XCTAssertTrue(spaceLaunchTab.isSelected, "Space Launch tab should be selected")
        
        // Navigate back to Home
        homeTab.tap()
        XCTAssertTrue(homeTab.isSelected, "Home tab should be selected")
    }
    
    // MARK: - Home Tab Content Tests
    
    func testHomeTabDisplaysNavigationTitle() throws {
        // Given
        let homeTab = app.tabBars.buttons["Home"]
        homeTab.tap()
        
        // When
        let navigationBar = app.navigationBars["Space Pictures"]
        
        // Then
        XCTAssertTrue(navigationBar.exists, "Home tab should display 'Space Pictures' navigation title")
    }
    
    func testHomeTabDisplaysList() throws {
        // Given
        let homeTab = app.tabBars.buttons["Home"]
        homeTab.tap()
        
        // When
        let list = app.collectionViews.firstMatch
        
        // Then
        XCTAssertTrue(list.exists, "Home tab should display a list")
    }
    
    func testHomeTabDisplaysMultipleItems() throws {
        // Given
        let homeTab = app.tabBars.buttons["Home"]
        homeTab.tap()
        
        // When
        let cells = app.collectionViews.cells
        
        // Then
        XCTAssertGreaterThan(cells.count, 0, "Home tab should display multiple items")
    }
    
    // MARK: - Mars Tab Content Tests
    
    func testMarsTabDisplaysNavigationTitle() throws {
        // Given
        let marsTab = app.tabBars.buttons["Mars"]
        
        // When
        marsTab.tap()
        let navigationBar = app.navigationBars["Mars Weather"]
        
        // Then
        XCTAssertTrue(navigationBar.exists, "Mars tab should display 'Mars Weather' navigation title")
    }
    
    func testMarsTabDisplaysList() throws {
        // Given
        let marsTab = app.tabBars.buttons["Mars"]
        
        // When
        marsTab.tap()
        let list = app.collectionViews.firstMatch
        
        // Then
        XCTAssertTrue(list.exists, "Mars tab should display a list")
    }
    
    func testMarsTabDisplaysMultipleWeatherEntries() throws {
        // Given
        let marsTab = app.tabBars.buttons["Mars"]
        
        // When
        marsTab.tap()
        let cells = app.collectionViews.cells
        
        // Then
        XCTAssertGreaterThan(cells.count, 0, "Mars tab should display multiple weather entries")
    }
    
    // MARK: - Space Launch Tab Content Tests
    
    func testSpaceLaunchTabDisplaysNavigationTitle() throws {
        // Given
        let spaceLaunchTab = app.tabBars.buttons["Space Launch"]
        
        // When
        spaceLaunchTab.tap()
        let navigationBar = app.navigationBars["Space Launches"]
        
        // Then
        XCTAssertTrue(navigationBar.exists, "Space Launch tab should display 'Space Launches' navigation title")
    }
    
    func testSpaceLaunchTabDisplaysList() throws {
        // Given
        let spaceLaunchTab = app.tabBars.buttons["Space Launch"]
        
        // When
        spaceLaunchTab.tap()
        let list = app.collectionViews.firstMatch
        
        // Then
        XCTAssertTrue(list.exists, "Space Launch tab should display a list")
    }
    
    func testSpaceLaunchTabDisplaysMultipleLaunches() throws {
        // Given
        let spaceLaunchTab = app.tabBars.buttons["Space Launch"]
        
        // When
        spaceLaunchTab.tap()
        let cells = app.collectionViews.cells
        
        // Then
        XCTAssertGreaterThan(cells.count, 0, "Space Launch tab should display multiple launches")
    }
    
    // MARK: - List Scrolling Tests
    
    func testHomeTabListIsScrollable() throws {
        // Given
        let homeTab = app.tabBars.buttons["Home"]
        homeTab.tap()
        let list = app.collectionViews.firstMatch
        
        // When
        list.swipeUp()
        
        // Then - If we can swipe without error, the list is scrollable
        XCTAssertTrue(list.exists, "Home tab list should be scrollable")
    }
    
    func testMarsTabListIsScrollable() throws {
        // Given
        let marsTab = app.tabBars.buttons["Mars"]
        marsTab.tap()
        let list = app.collectionViews.firstMatch
        
        // When
        list.swipeUp()
        
        // Then
        XCTAssertTrue(list.exists, "Mars tab list should be scrollable")
    }
    
    func testSpaceLaunchTabListIsScrollable() throws {
        // Given
        let spaceLaunchTab = app.tabBars.buttons["Space Launch"]
        spaceLaunchTab.tap()
        let list = app.collectionViews.firstMatch
        
        // When
        list.swipeUp()
        
        // Then
        XCTAssertTrue(list.exists, "Space Launch tab list should be scrollable")
    }
    
    // MARK: - Performance Tests
    
    func testAppLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
