# Mars Rover Photos API Integration Plan

## Overview

This document outlines the plan to integrate NASA's Mars Rover Photos API into the Space Explorer app. This feature will be added to the Mars page, allowing users to browse through various pictures taken by Mars Rovers.

## API Information

### Base URL
```
https://api.nasa.gov/mars-photos/api/v1
```

### Endpoints

#### Get Photos by Sol (Martian Day)
```
GET /rovers/{rover_name}/photos?sol={sol}&api_key={API_KEY}
```

#### Get Photos by Sol and Camera
```
GET /rovers/{rover_name}/photos?sol={sol}&camera={camera}&api_key={API_KEY}
```

#### Get Photos with Pagination
```
GET /rovers/{rover_name}/photos?sol={sol}&page={page}&api_key={API_KEY}
```

### Available Rovers
- **Curiosity** - Active rover, launched in 2011
- **Opportunity** - Mission ended in 2019
- **Spirit** - Mission ended in 2010
- **Perseverance** - Active rover, launched in 2020

### Available Cameras

#### Curiosity Cameras
- **FHAZ** - Front Hazard Avoidance Camera
- **RHAZ** - Rear Hazard Avoidance Camera
- **MAST** - Mast Camera
- **CHEMCAM** - Chemistry and Camera Complex
- **MAHLI** - Mars Hand Lens Imager
- **MARDI** - Mars Descent Imager
- **NAVCAM** - Navigation Camera

#### Perseverance Cameras
- **EDL_RUCAM** - Rover Up-Look Camera
- **EDL_RDCAM** - Rover Down-Look Camera
- **EDL_DDCAM** - Descent Stage Down-Look Camera
- **EDL_PUCAM1** - Parachute Up-Look Camera A
- **EDL_PUCAM2** - Parachute Up-Look Camera B
- **NAVCAM_LEFT** - Navigation Camera - Left
- **NAVCAM_RIGHT** - Navigation Camera - Right
- **MCZ_LEFT** - Mast Camera Zoom - Left
- **MCZ_RIGHT** - Mast Camera Zoom - Right
- **FRONT_HAZCAM_LEFT_A** - Front Hazard Avoidance Camera - Left
- **FRONT_HAZCAM_RIGHT_A** - Front Hazard Avoidance Camera - Right
- **REAR_HAZCAM_LEFT** - Rear Hazard Avoidance Camera - Left
- **REAR_HAZCAM_RIGHT** - Rear Hazard Avoidance Camera - Right

## Example Queries

### Basic Query - Get Photos from Sol 1000
```
https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY
```

### Filter by Camera - Front Hazard Camera
```
https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY
```

### Pagination - Get Second Page of Results
```
https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=DEMO_KEY
```

## Response Format

### Example Response
```json
{
  "photos": [
    {
      "id": 102693,
      "sol": 1000,
      "camera": {
        "id": 20,
        "name": "FHAZ",
        "rover_id": 5,
        "full_name": "Front Hazard Avoidance Camera"
      },
      "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG",
      "earth_date": "2015-05-30",
      "rover": {
        "id": 5,
        "name": "Curiosity",
        "landing_date": "2012-08-06",
        "launch_date": "2011-11-26",
        "status": "active"
      }
    }
  ]
}
```

## Implementation Plan

### Phase 1: Data Models

#### MarsRoverPhoto Model
Create a new model to represent a Mars Rover photo with the following properties:
- `id`: Unique photo identifier
- `sol`: Martian day
- `earthDate`: Earth date when photo was taken
- `imageURL`: URL to the photo
- `cameraName`: Name of the camera
- `cameraFullName`: Full name of the camera
- `roverName`: Name of the rover

#### MarsRoverCamera Model
Create a model to represent camera information:
- `id`: Camera identifier
- `name`: Short camera name
- `fullName`: Full camera name

#### MarsRover Model
Create a model to represent rover information:
- `id`: Rover identifier
- `name`: Rover name
- `landingDate`: Landing date on Mars
- `launchDate`: Launch date from Earth
- `status`: Current status (active/inactive)

### Phase 2: Service Layer

#### MarsRoverService
Create a new service class `MarsRoverService.swift` with methods:
- `fetchPhotos(rover:sol:camera:page:completion:)` - Fetch photos with optional filters
- `fetchRoverInfo(rover:completion:)` - Fetch rover information
- Helper methods for URL construction and response parsing

### Phase 3: UI Components

#### MarsRoverPhotosView
Create a new view component that:
- Displays a grid or list of rover photos
- Includes filters for:
  - Rover selection (Curiosity, Perseverance, etc.)
  - Sol (Martian day) input
  - Camera selection
- Implements pagination for loading more photos
- Shows loading indicators while fetching
- Handles errors gracefully with fallback UI
- Supports pull-to-refresh

#### Photo Detail View
Create a detailed view for individual photos showing:
- Full-size image
- Photo metadata (sol, Earth date, camera, rover)
- Option to share or save photo

### Phase 4: Integration with Mars Page

Update `MarsView.swift` to include:
- Navigation to the new MarsRoverPhotosView
- Button or tab to access rover photos
- Maintain existing Mars weather functionality

### Phase 5: Testing

#### Unit Tests
- Test MarsRoverPhoto model decoding
- Test MarsRoverService API calls
- Test URL construction with different parameters

#### Integration Tests
- Test MarsRoverPhotosView rendering
- Test filter functionality
- Test pagination

#### UI Tests
- Test navigation to rover photos
- Test photo selection and detail view
- Test filter interactions

## API Key Usage

The Mars Rover Photos API will use the same NASA API key configuration as existing services:
- Read from `APIConfiguration.nasaAPIKey`
- Falls back to `DEMO_KEY` if not configured
- Same rate limits apply as other NASA APIs

## UI Design Considerations

### Grid Layout
- Use LazyVGrid for efficient photo grid display
- Thumbnail images loaded asynchronously
- Smooth scrolling with pagination

### Filters Section
- Expandable/collapsible filter panel
- Rover picker (segmented control or picker)
- Sol input field with validation
- Camera picker with grouped options
- Apply/Reset filter buttons

### Error Handling
- Show message when no photos available for selected sol
- Handle network errors gracefully
- Provide sample data for offline mode

## Dependencies

No new external dependencies required. Implementation will use:
- SwiftUI for UI components
- Combine framework for data flow
- URLSession for network requests
- Standard iOS image loading

## Performance Considerations

- Implement image caching to reduce API calls
- Use lazy loading for grid items
- Limit initial photo fetch to 25 photos per page
- Implement pagination for better performance
- Use AsyncImage for efficient image loading

## Timeline Estimate

- Phase 1 (Models): 2-3 hours
- Phase 2 (Service): 3-4 hours
- Phase 3 (UI): 5-6 hours
- Phase 4 (Integration): 2 hours
- Phase 5 (Testing): 4-5 hours

**Total Estimated Time**: 16-20 hours

## Future Enhancements

- Favorite photos functionality
- Filter by Earth date instead of sol
- Advanced search capabilities
- Photo comparison view
- Download photos to device
- Share photos to social media
- 3D/panoramic photo viewer for supported images
