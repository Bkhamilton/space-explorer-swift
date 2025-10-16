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
