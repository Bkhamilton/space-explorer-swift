# Testing the NASA API Integration

## Quick Start Guide

This document helps you test the newly implemented NASA API integration.

## Prerequisites

1. **Xcode**: Version 15.0+ installed
2. **NASA API Key**: Get one from https://api.nasa.gov/ (takes 30 seconds)
3. **Internet Connection**: Required for API calls

## Step 1: Get Your NASA API Key

1. Visit https://api.nasa.gov/
2. Enter your first name, last name, and email
3. Click "Signup"
4. Check your email for the API key
5. Copy the API key (you'll need it in the next step)

## Step 2: Configure the API Key in Xcode

### Option A: Using Your Own API Key (Recommended)

1. Open `SpaceExplorer.xcodeproj` in Xcode
2. Go to **Product** → **Scheme** → **Edit Scheme...** (or press ⌘<)
3. Select **Run** from the left sidebar
4. Click the **Arguments** tab
5. In the **Environment Variables** section, click the **+** button
6. Add:
   - **Name:** `NASA_API_KEY`
   - **Value:** (paste your API key here)
7. ✅ Check the checkbox to enable it
8. Click **Close**

### Option B: Using DEMO_KEY (Limited)

If you skip the above step, the app will use `DEMO_KEY` which has strict limits:
- 30 requests per hour
- 50 requests per day

This is fine for quick testing but not recommended for regular use.

## Step 3: Build and Run

1. Select a simulator (iPhone 15 recommended) or physical device
2. Press **⌘R** or click the Run button
3. Wait for the app to build and launch

## Step 4: Test the Home Page (APOD API)

### What to Expect:
1. **Loading State**: You'll see "Loading space pictures..." briefly
2. **Data Display**: After 1-3 seconds, you should see 5 space pictures with:
   - Astronomy-related titles
   - Dates (various dates, not sequential)
   - Descriptions explaining what the picture shows
   - Photo icon (📷) instead of various SF Symbols

### Testing Actions:
- **Tap the refresh button** (↻) in the top-right corner
  - Should load 5 different random space pictures
  - Loading indicator appears again
  - New content replaces old content

### If You See an Error:
- Check your internet connection
- Verify your API key is set correctly
- Check if you've exceeded rate limits (wait an hour if using DEMO_KEY)
- The app will show sample data (Andromeda Galaxy, Eagle Nebula, etc.)

## Step 5: Test the Mars Page (InSight API)

### What to Expect:
1. **Loading State**: You'll see "Loading Mars weather..." briefly
2. **Likely Outcome**: You'll see a note saying "InSight mission ended. Showing sample data."
3. **Sample Data Display**: Mars weather data for sols 4008-4012 with:
   - Sol numbers (Martian days)
   - Earth dates
   - Temperature ranges
   - Pressure readings
   - Wind speed data
   - Season information

### Why Sample Data?
The InSight Mars lander mission ended in December 2022, so the API no longer returns live data. This is expected behavior and demonstrates proper error handling.

### Testing Actions:
- **Tap the refresh button** (↻) in the top-right corner
  - Should attempt to fetch data again
  - Will show the same informational message
  - Sample data remains displayed

## Step 6: Test Error Handling

### Test 1: Invalid API Key
1. Edit the scheme and set `NASA_API_KEY` to `INVALID_KEY`
2. Run the app
3. **Expected**: Error message on Home page, sample data still visible

### Test 2: No Internet
1. Disable WiFi/network on your device
2. Force quit and restart the app
3. **Expected**: Error messages on both pages, sample data visible

### Test 3: Rate Limit (if using DEMO_KEY)
1. Use DEMO_KEY
2. Tap refresh button multiple times quickly (>30 times)
3. **Expected**: Rate limit error, sample data remains

## Step 7: Verify Test Suite

Run the unit tests to ensure everything is working:

1. Press **⌘U** or go to **Product** → **Test**
2. Wait for tests to complete
3. **Expected Results**:
   - All existing tests should pass
   - New API service tests should pass
   - Total test count should be higher than before

### Test Files Added:
- `APODServiceTests.swift` - Tests for APOD API service
- `InSightServiceTests.swift` - Tests for InSight API service

## Verification Checklist

Use this checklist to verify the implementation:

### Home Page (APOD)
- [ ] App launches successfully
- [ ] Loading indicator appears briefly
- [ ] Data loads from NASA API (or error shown)
- [ ] 5 space pictures displayed
- [ ] Pictures have titles, dates, and descriptions
- [ ] Refresh button works
- [ ] Error handling works (when internet disconnected)
- [ ] Sample data shown as fallback

### Mars Page (InSight)
- [ ] Page loads successfully
- [ ] Loading indicator appears briefly
- [ ] Informational message about InSight mission displayed
- [ ] Sample weather data displayed
- [ ] Data shows sols, dates, temperatures, pressure, wind speed
- [ ] Refresh button works
- [ ] Error handling works

### General
- [ ] API key configured via environment variable
- [ ] No API key hardcoded in source files
- [ ] All unit tests pass
- [ ] App doesn't crash on any page
- [ ] Navigation between tabs works smoothly

## Troubleshooting

### "Command PhaseScriptExecution failed with a nonzero exit code"
- Clean build folder: **Product** → **Clean Build Folder** (⌘⇧K)
- Try again

### "Could not find module 'ViewInspector'"
- This is normal in this environment
- The tests that require ViewInspector will be skipped
- Other tests should still run

### API Not Returning Data
1. Check Console log for error messages
2. Verify API key is correct
3. Try using DEMO_KEY to rule out key issues
4. Check https://api.nasa.gov/api-status for API status

### App Crashes on Launch
- Check Console for crash logs
- Verify all files were committed
- Clean build folder and rebuild

## Success Criteria

Your implementation is successful if:

✅ Home page loads space pictures from APOD API
✅ Mars page attempts to load InSight data (shows appropriate message)
✅ Loading states are visible during API calls
✅ Error handling works (try disconnecting internet)
✅ Refresh buttons update the data
✅ Sample data is shown when API unavailable
✅ Unit tests pass
✅ No crashes or compile errors

## What's Next?

After verifying the implementation works:

1. **Read the Documentation**:
   - `NASA_API_GUIDE.md` - Comprehensive API setup guide
   - `API_IMPLEMENTATION_SUMMARY.md` - Technical implementation details
   - Updated `README.md` - Project overview

2. **Explore the Code**:
   - `SpaceExplorer/Services/` - API service implementations
   - `SpaceExplorer/Views/` - Updated view implementations
   - `SpaceExplorerTests/` - New test files

3. **Future Enhancements**:
   - Add image loading from APOD URLs
   - Implement image caching
   - Add more NASA APIs
   - Add detailed views for each item

## Support

If you encounter issues:

1. Check the Console log in Xcode for error messages
2. Review the `NASA_API_GUIDE.md` for setup instructions
3. Verify your NASA API key is valid
4. Check your internet connection
5. Ensure you're using Xcode 15.0+ and iOS 16.0+

## Enjoy!

You now have a working Space Explorer app with real NASA data! 🚀🌌

Try refreshing the Home page multiple times to see different space pictures from NASA's archives. Each refresh will show you 5 random astronomical images with fascinating descriptions.
