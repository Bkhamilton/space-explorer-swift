# NASA API Integration Guide

## Overview

This app integrates with two NASA APIs:
1. **APOD (Astronomy Picture of the Day)** - Displays space pictures on the Home page
2. **InSight Mars Weather** - Displays Mars weather data on the Mars page

## Setting Up Your API Key

### Getting an API Key

1. Visit [https://api.nasa.gov/](https://api.nasa.gov/)
2. Sign up for a free API key (takes just a few seconds)
3. You'll receive your API key via email

### Using Environment Variables in Xcode

To use your NASA API key without exposing it in the code:

#### Option 1: Set Environment Variable in Xcode Scheme

1. Open the project in Xcode
2. Go to **Product > Scheme > Edit Scheme** (or press ⌘<)
3. Select **Run** from the left sidebar
4. Select the **Arguments** tab
5. In the **Environment Variables** section, click the **+** button
6. Add:
   - **Name:** `NASA_API_KEY`
   - **Value:** Your actual NASA API key
7. Click **Close**

#### Option 2: Use DEMO_KEY (Rate Limited)

If you don't set the environment variable, the app will use `DEMO_KEY` which has limited requests per hour (30 requests/hour, 50 requests/day).

## API Endpoints Used

### APOD API
- **URL:** `https://api.nasa.gov/planetary/apod`
- **Parameters:**
  - `api_key`: Your NASA API key
  - `count`: Number of random images to fetch (default: 5)
- **Features:**
  - Fetches astronomy pictures with descriptions
  - Displays on the Home page
  - Pull-to-refresh to load new images

### InSight Mars Weather API
- **URL:** `https://api.nasa.gov/insight_weather/`
- **Parameters:**
  - `api_key`: Your NASA API key
  - `feedtype`: json
  - `ver`: 1.0
- **Note:** The InSight mission ended in December 2022, so live data may not be available. The app will gracefully fall back to sample data.

## Features

### Home Page (Space Pictures)
- Displays astronomy pictures from NASA's APOD API
- Shows title, date, and description
- Refresh button to load new pictures
- Loading indicator while fetching data
- Error handling with fallback to sample data

### Mars Page (Mars Weather)
- Displays Mars weather data from InSight API
- Shows sol (Martian day), Earth date, temperature, pressure, and wind speed
- Refresh button to fetch latest data
- Falls back to sample data if API is unavailable
- Note displayed when InSight mission data is not available

## Code Structure

```
SpaceExplorer/
├── Services/
│   ├── APIConfiguration.swift    # Environment variable configuration
│   ├── APODService.swift         # APOD API service
│   └── InSightService.swift      # InSight Weather API service
├── Models/
│   ├── SpacePicture.swift        # Extended to support APOD data
│   └── MarsWeather.swift         # Mars weather data model
└── Views/
    ├── HomeView.swift            # Updated to fetch APOD data
    └── MarsView.swift            # Updated to fetch Mars weather
```

## Testing

The project includes unit tests for the API services:
- `APODServiceTests.swift` - Tests for APOD service and JSON decoding
- `InSightServiceTests.swift` - Tests for InSight service and data parsing

Run tests with ⌘U in Xcode.

## Rate Limits

### With API Key
- Hourly Limit: 1,000 requests per hour

### With DEMO_KEY
- Hourly Limit: 30 requests per hour
- Daily Limit: 50 requests per day

## Troubleshooting

### "Invalid API Key" Error
- Verify your API key is correct
- Check that the environment variable is set in the scheme
- Try using DEMO_KEY to test the connection

### "No Data Available" Error
- Check your internet connection
- InSight API may not return data (mission ended)
- APOD API may be temporarily unavailable

### Rate Limit Exceeded
- Wait for the rate limit window to reset
- Consider getting your own API key instead of using DEMO_KEY
- The app will display cached/sample data while rate limited

## Privacy Note

Your API key is stored only in the Xcode scheme and is **never** committed to version control. The `APIConfiguration.swift` file reads the key from environment variables at runtime, keeping your key secure.
