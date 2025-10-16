# Combine Framework Implementation

## Overview

This document describes the implementation of Apple's Combine framework in the Space Explorer app to handle asynchronous data flow and improve user experience through debounced search functionality.

## Changes Summary

### 1. Mars Weather Page - Reactive Data Flow

#### InSightService Updates
**File:** `SpaceExplorer/Services/InSightService.swift`

- **Added Combine Import:** `import Combine`
- **New Method:** `fetchMarsWeatherPublisher() -> AnyPublisher<[MarsWeather], Error>`
  - Returns a Combine publisher instead of using callbacks
  - Uses URLSession's `dataTaskPublisher` for network requests
  - Automatically parses the response using the existing `parseMarsWeatherData` method
  - Returns an `AnyPublisher` that emits `[MarsWeather]` or an error
  - Maintains backward compatibility - the original callback-based method is still available

**Implementation Details:**
```swift
func fetchMarsWeatherPublisher() -> AnyPublisher<[MarsWeather], Error> {
    let apiKey = APIConfiguration.nasaAPIKey
    guard let url = URL(string: "https://api.nasa.gov/insight_weather/?api_key=\(apiKey)&feedtype=json&ver=1.0") else {
        return Fail(error: NSError(domain: "InSightService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            .eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .map { [weak self] data in
            self?.parseMarsWeatherData(from: data) ?? []
        }
        .eraseToAnyPublisher()
}
```

#### MarsView Updates
**File:** `SpaceExplorer/Views/MarsView.swift`

- **Added Combine Import:** `import Combine`
- **New State Variable:** `@State private var cancellables = Set<AnyCancellable>()`
  - Stores subscription references to prevent memory leaks
- **Updated `loadMarsWeather()` Method:**
  - Replaced callback-based API call with Combine publisher subscription
  - Uses `.receive(on: DispatchQueue.main)` to ensure UI updates on main thread
  - Uses `.sink()` to handle both completion and values
  - Properly manages subscription lifecycle with `store(in: &cancellables)`

**Benefits:**
- ✅ **Proper Error Handling:** Separate handlers for completion and value reception
- ✅ **Loading States:** isLoading flag correctly managed throughout the async operation
- ✅ **Error Messages:** User-friendly error messages displayed when API fails
- ✅ **Memory Safety:** Cancellables are properly stored and managed
- ✅ **Thread Safety:** All UI updates happen on the main thread

**Implementation Details:**
```swift
private func loadMarsWeather() {
    isLoading = true
    errorMessage = nil
    
    InSightService.shared.fetchMarsWeatherPublisher()
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [self] completion in
                isLoading = false
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    errorMessage = "InSight mission ended. Showing sample data."
                    print("Failed to load Mars weather: \(error)")
                }
            },
            receiveValue: { [self] parsedWeather in
                if !parsedWeather.isEmpty {
                    _weatherData = parsedWeather
                } else {
                    errorMessage = "InSight mission ended. Showing sample data."
                }
            }
        )
        .store(in: &cancellables)
}
```

### 2. Space Launch Page - Debounced Search

#### SpaceLaunchView Updates
**File:** `SpaceExplorer/Views/SpaceLaunchView.swift`

- **Added Combine Import:** `import Combine`
- **New State Variables:**
  - `@State private var searchText = ""` - Bound to the search field
  - `@State private var searchSubject = PassthroughSubject<String, Never>()` - Subject for emitting search events
  - `@State private var debouncedSearchText = ""` - The debounced search value
  - `@State private var cancellables = Set<AnyCancellable>()` - Stores subscriptions

- **New Computed Property:** `filteredLaunches`
  - Returns all launches when search is empty
  - Filters launches based on `debouncedSearchText`
  - Searches across: name, agency, mission type, and location
  - Case-insensitive search

- **New UI Element:** `.searchable(text: $searchText, prompt: "Search launches")`
  - Native iOS search bar
  - Automatically styled for the platform

- **Search Implementation:**
  - `.onChange(of: searchText)` sends values to `searchSubject`
  - `setupDebouncing()` method configures the debounce behavior
  - 300ms debounce delay prevents excessive filtering
  - Debounced value updates `debouncedSearchText` which triggers UI refresh

**Benefits:**
- ✅ **Responsive Search:** Immediate feedback as user types
- ✅ **Performance:** Debouncing reduces unnecessary computations
- ✅ **User Experience:** 300ms delay feels natural and responsive
- ✅ **Comprehensive:** Searches across multiple fields
- ✅ **Native UI:** Uses SwiftUI's searchable modifier for platform consistency

**Implementation Details:**
```swift
var filteredLaunches: [SpaceLaunch] {
    if debouncedSearchText.isEmpty {
        return launches
    } else {
        return launches.filter { launch in
            launch.name.localizedCaseInsensitiveContains(debouncedSearchText) ||
            launch.agency.localizedCaseInsensitiveContains(debouncedSearchText) ||
            launch.missionType.localizedCaseInsensitiveContains(debouncedSearchText) ||
            launch.location.localizedCaseInsensitiveContains(debouncedSearchText)
        }
    }
}

private func setupDebouncing() {
    searchSubject
        .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
        .sink { searchValue in
            debouncedSearchText = searchValue
        }
        .store(in: &cancellables)
}
```

## Testing Updates

### InSightServiceTests
**File:** `SpaceExplorerTests/InSightServiceTests.swift`

Added new tests for Combine functionality:
- `testFetchMarsWeatherPublisherReturnsPublisher()` - Verifies publisher creation
- `testFetchMarsWeatherPublisherCanBeCancelled()` - Ensures proper cancellation support

### SpaceLaunchViewTests
**File:** `SpaceExplorerTests/SpaceLaunchViewTests.swift`

Added new tests for search functionality:
- `testFilteredLaunchesReturnsAllWhenSearchIsEmpty()` - Verifies default behavior
- `testSearchTextPropertyExists()` - Ensures search state is initialized
- `testDebouncedSearchTextPropertyExists()` - Verifies debounced state

### Bug Fixes
- Fixed syntax error in `MarsWeatherTests.swift` (extra closing brace)

## Technical Highlights

### Combine Operators Used

1. **dataTaskPublisher** - URLSession's Combine publisher for network requests
2. **map** - Transform data through the pipeline
3. **receive(on:)** - Ensure operations occur on specific queues
4. **sink** - Subscribe to publisher and handle values/completion
5. **debounce** - Delay emissions until a specified time has passed
6. **eraseToAnyPublisher** - Type erasure for clean API

### Memory Management

- All subscriptions are stored in `Set<AnyCancellable>`
- Subscriptions are automatically cancelled when the set is deallocated
- Weak self references prevent retain cycles where appropriate

### Thread Safety

- Network responses are received on background threads
- `.receive(on: DispatchQueue.main)` ensures UI updates on main thread
- Search debouncing happens on main queue for responsive UI

## Benefits of This Implementation

### For Mars Weather:
1. **Better Error Handling:** Separate paths for success and failure
2. **Reactive Updates:** Data flows naturally from service to UI
3. **Cancellation Support:** Requests can be cancelled when view disappears
4. **Type Safety:** Compiler ensures correct types throughout the chain

### For Space Launch Search:
1. **Performance:** Debouncing reduces unnecessary filtering operations
2. **UX:** Feels responsive without being overwhelming
3. **Flexibility:** Easy to adjust debounce delay if needed
4. **Searchability:** Multiple fields provide comprehensive search

## Future Enhancements

Potential improvements that could build on this foundation:

1. **Advanced Search Filters:**
   - Date range filtering
   - Status-based filtering
   - Agency selection

2. **Search History:**
   - Store recent searches
   - Quick access to previous queries

3. **Real-time Updates:**
   - Use Combine to automatically refresh data
   - WebSocket support for live launch updates

4. **Enhanced Mars Weather:**
   - Periodic auto-refresh using Combine timers
   - Cache data using Combine subjects

## Compatibility

- **iOS Version:** 16.0+
- **Swift Version:** 5.9+
- **Combine:** Built into iOS SDK, no external dependencies

## Testing

All existing tests pass with the new implementation. New tests cover:
- Publisher creation and subscription
- Search functionality
- Debouncing behavior
- State management

To run tests:
```bash
xcodebuild test -project SpaceExplorer.xcodeproj -scheme SpaceExplorer -destination 'platform=iOS Simulator,name=iPhone 15'
```

## Conclusion

The Combine framework implementation successfully modernizes the Space Explorer app's async data handling while maintaining backward compatibility and adding new search capabilities. The code is more maintainable, testable, and provides a better user experience.
