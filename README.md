# Space Explorer

A Space Exploration Data App made using SwiftUI

## Overview

Space Explorer is an iOS app built with SwiftUI that provides information about space through three main sections:
- **Home**: Browse interesting space pictures with descriptions
- **Mars**: View Mars weather data including temperature, pressure, and wind speed
- **Space Launch**: Explore upcoming and past space launches from various agencies

## Features

- **Tab-based Navigation**: Easy navigation between three main sections
- **Hardcoded Sample Data**: Includes realistic sample data for demonstration
- **Clean SwiftUI Design**: Modern iOS interface using native SwiftUI components
- **System Icons**: Uses SF Symbols for consistent iconography

## Project Structure

```
SpaceExplorer/
├── SpaceExplorerApp.swift      # Main app entry point
├── ContentView.swift            # Tab bar view
├── Views/
│   ├── HomeView.swift          # Space pictures view
│   ├── MarsView.swift          # Mars weather view
│   └── SpaceLaunchView.swift   # Space launches view
├── Models/
│   ├── SpacePicture.swift      # Space picture data model
│   ├── MarsWeather.swift       # Mars weather data model
│   └── SpaceLaunch.swift       # Space launch data model
└── Assets.xcassets/            # App assets and icons

SpaceExplorerTests/
├── SpacePictureTests.swift     # Unit tests for SpacePicture model
├── MarsWeatherTests.swift      # Unit tests for MarsWeather model
├── SpaceLaunchTests.swift      # Unit tests for SpaceLaunch model
├── HomeViewTests.swift         # Integration tests for HomeView
├── MarsViewTests.swift         # Integration tests for MarsView
├── SpaceLaunchViewTests.swift  # Integration tests for SpaceLaunchView
└── ContentViewTests.swift      # Integration tests for ContentView

SpaceExplorerUITests/
└── SpaceExplorerUITests.swift  # End-to-end UI tests
```

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## Getting Started

1. Clone the repository
2. Open `SpaceExplorer.xcodeproj` in Xcode
3. Select a simulator or device
4. Build and run (⌘R)

## Running Tests

### Unit & Integration Tests
- Press ⌘U in Xcode to run all tests
- Or select Product > Test from the menu
- View results in the Test Navigator (⌘6)

### Command Line
```bash
xcodebuild test -project SpaceExplorer.xcodeproj -scheme SpaceExplorer -destination 'platform=iOS Simulator,name=iPhone 15'
```

For detailed test documentation, see [TEST_DOCUMENTATION.md](TEST_DOCUMENTATION.md).

## Data Models

### SpacePicture
- Title, description, date
- System icon name for visual representation

### MarsWeather
- Sol (Martian day), Earth date
- Min/max temperature, pressure, wind speed
- Martian season

### SpaceLaunch
- Launch name, agency, date, location
- Mission type and status (Scheduled/Launched)

## Future Enhancements

- Integration with NASA APIs for real-time data
- Detailed view pages for each item
- Image caching and loading
- Search and filter capabilities
- Favorites functionality

## Testing

The project includes comprehensive test coverage:
- **101 total tests** covering models, views, and UI
- Unit tests for all data models
- Integration tests for all views
- End-to-end UI tests for user interactions

See [TEST_DOCUMENTATION.md](TEST_DOCUMENTATION.md) for complete test documentation.
