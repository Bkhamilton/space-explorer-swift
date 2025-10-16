# Space Explorer App - UI Documentation

## App Structure

The Space Explorer app uses a `TabView` to provide easy navigation between three main sections. Each tab has its own dedicated view with specific functionality.

## Tab Bar Navigation

The tab bar is located at the bottom of the screen with three tabs:

1. **Home Tab** - Icon: photo.fill (📷)
2. **Mars Tab** - Icon: globe (🌍)
3. **Space Launch Tab** - Icon: rocket.fill (🚀)

---

## 1. Home View - Space Pictures

### Layout
- **Navigation Title**: "Space Pictures"
- **View Type**: List with custom cells

### Each Picture Item Displays:
- **Icon**: Large SF Symbol icon representing the celestial object (star, sparkles, etc.)
- **Title**: Name of the space object (e.g., "Andromeda Galaxy")
- **Date**: Date the image was taken or featured
- **Description**: Brief description of the object (truncated to 3 lines)

### Sample Data Shown:
- Andromeda Galaxy (2024-10-15)
- Eagle Nebula (2024-10-14)
- Hubble Deep Field (2024-10-13)
- Jupiter's Great Red Spot (2024-10-12)
- Saturn's Rings (2024-10-11)

### Visual Design:
```
┌────────────────────────────────────────┐
│ ← Space Pictures                       │
├────────────────────────────────────────┤
│  ⭐  Andromeda Galaxy                  │
│      2024-10-15                        │
│                                        │
│  The Andromeda Galaxy is a barred     │
│  spiral galaxy and is the nearest...  │
├────────────────────────────────────────┤
│  ✨  Eagle Nebula                      │
│      2024-10-14                        │
│                                        │
│  The Eagle Nebula is a young open     │
│  cluster of stars in the...           │
├────────────────────────────────────────┤
│  ⊞  Hubble Deep Field                  │
│      2024-10-13                        │
│                                        │
│  An image of a small region in the    │
│  constellation Ursa Major...           │
└────────────────────────────────────────┘
```

---

## 2. Mars View - Weather Data

### Layout
- **Navigation Title**: "Mars Weather"
- **View Type**: List with detailed weather cards

### Each Weather Entry Displays:
- **Sol Number**: Martian day count (e.g., "Sol 4012")
- **Earth Date**: Corresponding Earth date
- **Season**: Martian seasonal information (e.g., "Month 6")
- **Temperature Range**: Min to Max in Celsius
- **Pressure**: Atmospheric pressure in Pascals
- **Wind Speed**: Wind velocity in m/s

### Sample Data Shown:
- Sol 4012 (2024-10-15): -89°C to -18°C, 750 Pa, 12 m/s
- Sol 4011 (2024-10-14): -92°C to -15°C, 748 Pa, 15 m/s
- Sol 4010 (2024-10-13): -87°C to -20°C, 752 Pa, 10 m/s
- Sol 4009 (2024-10-12): -91°C to -17°C, 749 Pa, 14 m/s
- Sol 4008 (2024-10-11): -88°C to -19°C, 751 Pa, 11 m/s

### Visual Design:
```
┌────────────────────────────────────────┐
│ ← Mars Weather                         │
├────────────────────────────────────────┤
│  Sol 4012              Month 6         │
│  2024-10-15                            │
│  ────────────────────────────────────  │
│  🌡 Temperature                         │
│  -89°C to -18°C                        │
│                                        │
│  📊 Pressure    💨 Wind Speed          │
│  750 Pa         12 m/s                 │
├────────────────────────────────────────┤
│  Sol 4011              Month 6         │
│  2024-10-14                            │
│  ────────────────────────────────────  │
│  🌡 Temperature                         │
│  -92°C to -15°C                        │
│                                        │
│  📊 Pressure    💨 Wind Speed          │
│  748 Pa         15 m/s                 │
└────────────────────────────────────────┘
```

---

## 3. Space Launch View - Launch Schedule

### Layout
- **Navigation Title**: "Space Launches"
- **View Type**: List with launch information cards

### Each Launch Entry Displays:
- **Launch Name**: Mission name and rocket type
- **Status Badge**: Color-coded status indicator
  - Blue = Scheduled
  - Green = Launched
- **Agency**: Space agency (SpaceX, NASA, ESA, ISRO, Blue Origin)
- **Launch Date**: Date of launch
- **Location**: Launch site location
- **Mission Type**: Type of mission (Communications, Crew Transport, etc.)

### Sample Data Shown:
- Falcon 9 - Starlink Group 6-25 (SpaceX, Oct 20, 2024)
- Artemis II (NASA, Sep 1, 2025)
- JUICE - Jupiter Icy Moons Explorer (ESA, Launched)
- Chandrayaan-3 (ISRO, Launched)
- New Glenn - First Flight (Blue Origin, Dec 1, 2024)
- Crew Dragon - Crew-8 (SpaceX, Nov 15, 2024)

### Visual Design:
```
┌────────────────────────────────────────┐
│ ← Space Launches                       │
├────────────────────────────────────────┤
│  Falcon 9 - Starlink Group 6-25       │
│                         [Scheduled]    │
│  🏢 SpaceX                             │
│  ────────────────────────────────────  │
│  📅 Date              🏷 Type          │
│  2024-10-20           Communications   │
│                                        │
│  📍 Cape Canaveral, FL                 │
├────────────────────────────────────────┤
│  Artemis II                            │
│                         [Scheduled]    │
│  🏢 NASA                               │
│  ────────────────────────────────────  │
│  📅 Date              🏷 Type          │
│  2025-09-01           Crewed Lunar...  │
│                                        │
│  📍 Kennedy Space Center, FL           │
├────────────────────────────────────────┤
│  JUICE - Jupiter Icy Moons Explorer    │
│                         [Launched]     │
│  🏢 ESA                                │
│  ────────────────────────────────────  │
│  📅 Date              🏷 Type          │
│  2023-04-14           Planetary Expl.. │
│                                        │
│  📍 Kourou, French Guiana              │
└────────────────────────────────────────┘
```

---

## Design Principles

### Color Scheme
- **Background**: System default (white in light mode, black in dark mode)
- **Accents**: Blue for interactive elements
- **Status Colors**:
  - Blue: Scheduled missions
  - Green: Launched missions
  - Orange: Mars season indicators
- **Text**:
  - Primary: System default
  - Secondary: Gray for less important information

### Typography
- **Navigation Titles**: Large, bold
- **Item Titles**: Headline weight
- **Body Text**: Subheadline/Body weight
- **Captions**: Smaller, secondary color

### Icons
All icons use SF Symbols for consistency:
- System icons like `photo.fill`, `globe`, `rocket.fill`
- Weather icons: `thermometer`, `gauge`, `wind`
- Information icons: `calendar`, `location.fill`, `tag`, `building.2`

### Layout
- Uses native SwiftUI `List` for scrollable content
- Consistent padding and spacing throughout
- Dividers to separate information sections within cards
- Navigation bars with titles for context

---

## Technical Features

### SwiftUI Components Used
- `TabView` for main navigation
- `NavigationView` in each tab for navigation bars
- `List` for scrollable content
- `VStack` and `HStack` for layouts
- `Label` for icon+text combinations
- System colors and SF Symbols

### Data Models
- `SpacePicture`: id, title, description, imageName, date
- `MarsWeather`: id, sol, earthDate, minTemp, maxTemp, pressure, windSpeed, season
- `SpaceLaunch`: id, name, agency, launchDate, location, missionType, status

### Hardcoded Sample Data
All data is defined as static sample arrays in model extensions:
- `SpacePicture.sampleData` - 5 items
- `MarsWeather.sampleData` - 5 items
- `SpaceLaunch.sampleData` - 6 items
