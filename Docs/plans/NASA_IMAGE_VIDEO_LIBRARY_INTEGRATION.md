# NASA Image and Video Library API Integration Plan

## Overview

This document outlines the plan to integrate NASA's Image and Video Library API into the Space Explorer app. This feature will be added to the Home page as a separate component that opens a dedicated page to browse and search NASA's extensive collection of images and videos.

## API Information

### Base URL
```
https://images-api.nasa.gov
```

### Endpoints

#### Search
```
GET /search?q={query}
```

#### Asset Information
```
GET /asset/{nasa_id}
```

#### Asset Manifest
```
GET /asset/{nasa_id}
```

### Search Parameters

- **q** (required) - Free text search query
- **center** - NASA center which published the media
- **description** - Terms to search for in the description field
- **description_508** - Terms to search for in the 508 description field
- **keywords** - Comma-separated keywords to search for
- **location** - Terms to search for in the location field
- **media_type** - Media types to filter on (image, video, audio)
- **nasa_id** - The NASA ID to search for
- **page** - Page number for pagination (default: 1)
- **photographer** - Terms to search for in the photographer field
- **secondary_creator** - Terms to search for in the secondary creator field
- **title** - Terms to search for in the title field
- **year_start** - Start year for results (format: YYYY)
- **year_end** - End year for results (format: YYYY)

## Example Queries

### Basic Search
```
https://images-api.nasa.gov/search?q=mars
```

### Search for Images Only
```
https://images-api.nasa.gov/search?q=apollo&media_type=image
```

### Search for Videos
```
https://images-api.nasa.gov/search?q=moon landing&media_type=video
```

### Search with Date Range
```
https://images-api.nasa.gov/search?q=hubble&year_start=2015&year_end=2023
```

### Search with Pagination
```
https://images-api.nasa.gov/search?q=space station&page=2
```

### Advanced Search - Multiple Criteria
```
https://images-api.nasa.gov/search?q=Mars&media_type=image&year_start=2020&keywords=Perseverance
```

## Response Format

### Search Response Example
```json
{
  "collection": {
    "version": "1.0",
    "href": "https://images-api.nasa.gov/search?q=mars",
    "items": [
      {
        "href": "https://images-assets.nasa.gov/image/PIA04413/collection.json",
        "data": [
          {
            "center": "JPL",
            "title": "Spirit Lander Unleashed",
            "nasa_id": "PIA04413",
            "date_created": "2003-01-09T00:00:00Z",
            "keywords": [
              "Mars",
              "Mars Exploration Rover MER"
            ],
            "media_type": "image",
            "description_508": "Painting of Mars rover",
            "secondary_creator": "NASA/JPL",
            "description": "This artist concept shows the deployment of the Mars Exploration Rover."
          }
        ],
        "links": [
          {
            "href": "https://images-assets.nasa.gov/image/PIA04413/PIA04413~thumb.jpg",
            "rel": "preview",
            "render": "image"
          }
        ]
      }
    ],
    "metadata": {
      "total_hits": 8234
    }
  }
}
```

### Asset Metadata Response
```json
{
  "collection": {
    "version": "1.0",
    "href": "https://images-assets.nasa.gov/image/PIA04413/collection.json",
    "items": [
      {
        "href": "https://images-assets.nasa.gov/image/PIA04413/PIA04413~orig.jpg"
      },
      {
        "href": "https://images-assets.nasa.gov/image/PIA04413/PIA04413~large.jpg"
      },
      {
        "href": "https://images-assets.nasa.gov/image/PIA04413/PIA04413~medium.jpg"
      },
      {
        "href": "https://images-assets.nasa.gov/image/PIA04413/PIA04413~small.jpg"
      },
      {
        "href": "https://images-assets.nasa.gov/image/PIA04413/PIA04413~thumb.jpg"
      }
    ]
  }
}
```

## Implementation Plan

### Phase 1: Data Models

#### NASAMediaItem Model
Create a model to represent a media item with properties:
- `nasaId`: Unique identifier for the item
- `title`: Title of the media
- `description`: Full description
- `dateCreated`: Creation/publication date
- `mediaType`: Type (image, video, audio)
- `keywords`: Array of keywords
- `center`: NASA center that published the item
- `photographer`: Photographer name (if available)
- `thumbnailURL`: URL to thumbnail image
- `previewURL`: URL to preview/full media

#### NASAMediaCollection Model
Create a model for search results:
- `items`: Array of NASAMediaItem
- `totalHits`: Total number of results
- `metadata`: Additional search metadata

#### MediaAsset Model
Create a model for asset URLs:
- `nasaId`: NASA ID
- `urls`: Array of URLs at different resolutions
- `originalURL`: URL to original/highest quality version

### Phase 2: Service Layer

#### NASAMediaService
Create a new service class `NASAMediaService.swift` with methods:
- `search(query:mediaType:page:yearStart:yearEnd:completion:)` - Search media with filters
- `fetchAssetMetadata(nasaId:completion:)` - Get asset URLs and metadata
- `fetchPopularMedia(completion:)` - Get curated/popular items
- Helper methods for URL construction and parsing

**Note**: This API does not require an API key, making it freely accessible.

### Phase 3: UI Components

#### NASAMediaLibraryView
Create the main library view with:
- Search bar at the top
- Filter options (media type, date range)
- Grid layout for media items
- Thumbnail images for each item
- Pull-to-refresh functionality
- Infinite scroll/pagination
- Loading indicators
- Empty state for no results

#### MediaSearchView
Create a dedicated search interface with:
- Search field with auto-complete suggestions
- Recent searches
- Popular/trending topics
- Category browsing (Mars, Moon, ISS, etc.)

#### MediaDetailView
Create a detailed view for individual items showing:
- Full-size image or video player
- Title and description
- Publication date and NASA center
- Keywords as tags
- Photographer/creator attribution
- Share and save options
- Related media recommendations

#### MediaFilterView
Create a filter panel with:
- Media type selector (All, Images, Videos, Audio)
- Date range picker
- NASA center filter
- Keyword chips
- Apply/Reset buttons

### Phase 4: Integration with Home Page

Update `HomeView.swift` to include:
- New navigation button/card for "NASA Media Library"
- Prominent placement in the UI
- Preview of featured/recent media items
- Smooth navigation to NASAMediaLibraryView
- Maintain existing APOD functionality

### Phase 5: Advanced Features

#### Search Functionality
- Real-time search as user types
- Search history storage (UserDefaults)
- Suggested searches based on popular topics
- Search filters persistence

#### Media Display
- Grid vs List toggle
- Sorting options (date, relevance, title)
- Media download capability
- Favorites/bookmarks system
- Share to social media

#### Video Support
- In-app video player using AVKit
- Video playback controls
- Quality selection for videos
- Thumbnail generation for videos

### Phase 6: Testing

#### Unit Tests
- Test NASAMediaItem model decoding
- Test NASAMediaService API calls
- Test search query construction
- Test pagination logic

#### Integration Tests
- Test NASAMediaLibraryView rendering
- Test search functionality
- Test filter combinations
- Test navigation flows

#### UI Tests
- Test navigation from Home page
- Test search interaction
- Test media item selection
- Test filter application
- Test pagination scrolling

## API Key Usage

**Important**: The NASA Image and Video Library API does **not** require an API key. This makes it:
- Free to use without registration
- No rate limits
- Simpler integration
- No configuration needed

## UI Design Considerations

### Grid Layout
- Adaptive grid based on device size
- 2 columns on iPhone portrait
- 3-4 columns on iPhone landscape
- 4-6 columns on iPad
- Smooth animations and transitions

### Search Interface
- Prominent search bar at top
- Search suggestions dropdown
- Recent searches quick access
- Clear button to reset search

### Media Cards
- Thumbnail with aspect ratio preservation
- Title overlay on thumbnail
- Media type indicator (video icon, etc.)
- Tap gesture to view details
- Long press for quick actions menu

### Filter Panel
- Slide-in panel from bottom
- Clear visual grouping of filters
- Selected filters shown as chips
- Easy to clear individual filters

### Error Handling
- Empty state with helpful suggestions
- Network error messages
- Retry buttons for failed requests
- Offline mode indicators

## Performance Considerations

### Image Loading
- Use AsyncImage for SwiftUI
- Implement progressive image loading
- Cache images to reduce network calls
- Lazy load images as user scrolls
- Use appropriate image sizes (thumbnail vs full)

### Search Optimization
- Debounce search input (300ms delay)
- Cancel previous requests when new search starts
- Cache recent search results
- Limit results per page to 25-50 items

### Memory Management
- Properly dispose of large images
- Use memory cache with size limits
- Clear cache when memory warning received
- Efficient video player lifecycle management

## Dependencies

No new external dependencies required. Implementation will use:
- SwiftUI for UI components
- Combine framework for search debouncing
- URLSession for network requests
- AVKit for video playback
- Built-in image caching

## Accessibility

### VoiceOver Support
- Descriptive labels for all images
- Search field properly labeled
- Filter options accessible
- Video controls accessible

### Dynamic Type
- Support for larger text sizes
- Flexible layout for text scaling
- Maintain readability at all sizes

### High Contrast
- Ensure sufficient contrast ratios
- Support high contrast mode
- Clear visual indicators for selections

## Timeline Estimate

- Phase 1 (Models): 2-3 hours
- Phase 2 (Service): 3-4 hours
- Phase 3 (UI Components): 8-10 hours
- Phase 4 (Integration): 2-3 hours
- Phase 5 (Advanced Features): 6-8 hours
- Phase 6 (Testing): 5-6 hours

**Total Estimated Time**: 26-34 hours

## Future Enhancements

- Collections/albums for organizing favorites
- Advanced filtering (by mission, astronaut, etc.)
- Download manager for batch downloads
- Offline mode with cached content
- AR view for 3D models (if API provides)
- Timeline view for chronological browsing
- Educational mode with detailed explanations
- Push notifications for new content
- Integration with other NASA APIs for related data
- Social features (share, comment, rate)
- Widget for home screen showing daily featured media
- Apple Watch companion app for quick browsing

## Example Categories for Quick Access

### Popular Topics
- Mars Exploration
- International Space Station
- Hubble Space Telescope
- Apollo Missions
- James Webb Space Telescope
- Earth from Space
- Astronauts
- Nebulae and Galaxies
- Solar System
- Space Shuttle Program

### Media Types
- Historic Missions
- Recent Discoveries
- Educational Content
- Mission Patches
- Spacecraft and Rockets
- Planetary Images
- Astronomical Objects

## Technical Notes

### URL Structure
The API returns relative URLs in some cases. Need to construct full URLs:
```
Base: https://images-assets.nasa.gov
Example: /image/PIA04413/PIA04413~thumb.jpg
Full URL: https://images-assets.nasa.gov/image/PIA04413/PIA04413~thumb.jpg
```

### Image Sizes
Available image sizes (when applicable):
- `~thumb.jpg` - Thumbnail (typically 200x200)
- `~small.jpg` - Small (typically 320px width)
- `~medium.jpg` - Medium (typically 640px width)
- `~large.jpg` - Large (typically 1024px width)
- `~orig.jpg` - Original full resolution

### Video Formats
Videos are typically available in:
- MP4 format
- Various resolutions
- Closed captions when available (SRT files)

### Pagination
- Default page size: 100 items
- Maximum items can be adjusted in implementation
- Track current page for infinite scroll
- Show page indicators for manual navigation

## Security Considerations

- Sanitize search input to prevent injection
- Validate URLs before loading media
- Handle malformed API responses gracefully
- Implement timeout for network requests
- Use HTTPS for all API calls
