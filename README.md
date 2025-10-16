# Space Explorer

A Space Exploration Data App made using SwiftUI

## Overview

Space Explorer is an iOS app built with SwiftUI that provides information about space through three main sections:
- **Home**: Browse interesting space pictures with descriptions
- **Mars**: View Mars weather data including temperature, pressure, and wind speed
- **Space Launch**: Explore upcoming and past space launches from various agencies

## Features

- **Tab-based Navigation**: Easy navigation between three main sections
- **NASA API Integration**: Real-time data from NASA's APOD and InSight APIs
- **Environment Variable Support**: Secure API key management
- **Clean SwiftUI Design**: Modern iOS interface using native SwiftUI components
- **System Icons**: Uses SF Symbols for consistent iconography
- **Error Handling**: Graceful fallback to sample data when APIs are unavailable

## Project Structure

```
SpaceExplorer/
├── SpaceExplorerApp.swift      # Main app entry point
├── ContentView.swift            # Tab bar view
├── Views/
│   ├── HomeView.swift          # Space pictures view (APOD API)
│   ├── MarsView.swift          # Mars weather view (InSight API)
│   └── SpaceLaunchView.swift   # Space launches view
├── Models/
│   ├── SpacePicture.swift      # Space picture data model
│   ├── MarsWeather.swift       # Mars weather data model
│   └── SpaceLaunch.swift       # Space launch data model
├── Services/
│   ├── APIConfiguration.swift  # API key configuration
│   ├── APODService.swift       # APOD API service
│   └── InSightService.swift    # InSight Weather API service
└── Assets.xcassets/            # App assets and icons

SpaceExplorerTests/
├── SpacePictureTests.swift     # Unit tests for SpacePicture model
├── MarsWeatherTests.swift      # Unit tests for MarsWeather model
├── SpaceLaunchTests.swift      # Unit tests for SpaceLaunch model
├── APODServiceTests.swift      # Unit tests for APOD service
├── InSightServiceTests.swift   # Unit tests for InSight service
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
3. (Optional) Set up your NASA API key:
   - Get a free API key from [https://api.nasa.gov/](https://api.nasa.gov/)
   - Go to Product > Scheme > Edit Scheme
   - Add environment variable: `NASA_API_KEY` = your key
   - See [NASA_API_GUIDE.md](NASA_API_GUIDE.md) for detailed instructions
4. Select a simulator or device
5. Build and run (⌘R)

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
- Supports initialization from APOD API responses

### MarsWeather
- Sol (Martian day), Earth date
- Min/max temperature, pressure, wind speed
- Martian season

### SpaceLaunch
- Launch name, agency, date, location
- Mission type and status (Scheduled/Launched)

## NASA APIs

### APOD (Astronomy Picture of the Day)
- Fetches daily space pictures with descriptions
- Integrated into Home page
- See [NASA_API_GUIDE.md](NASA_API_GUIDE.md) for setup instructions

### InSight Mars Weather
- Mars weather data from InSight lander
- Integrated into Mars page
- Note: Mission ended in 2022, may show sample data

## Future Enhancements

- Detailed view pages for each item
- Image caching and loading for APOD images
- Search and filter capabilities
- Favorites functionality
- Additional NASA API integrations

## Testing

The project includes comprehensive test coverage:
- **101 total tests** covering models, views, and UI
- Unit tests for all data models
- Integration tests for all views
- End-to-end UI tests for user interactions

See [TEST_DOCUMENTATION.md](TEST_DOCUMENTATION.md) for complete test documentation.
