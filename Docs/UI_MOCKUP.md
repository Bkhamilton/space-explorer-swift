# Mars Weather UI Layout

## Updated Weather Card Design

Each weather entry in the list now displays in an expanded card format:

```
┌─────────────────────────────────────────────────────────────┐
│  Sol 4012                                      Fall           │
│  2024-10-15                                   Month 10        │
│                                                               │
│  North: early winter    South: early summer                  │
│                                                               │
│  ─────────────────────────────────────────────────────────   │
│                                                               │
│  🌡️ Temperature                                              │
│  Min         Avg         Max                177,556 samples  │
│  -97°C       -62°C       -16°C                               │
│                                                               │
│  ─────────────────────────────────────────────────────────   │
│                                                               │
│  📊 Atmospheric Pressure                                     │
│  Min         Avg         Max                887,776 samples  │
│  722 Pa      751 Pa      769 Pa                              │
│                                                               │
│  ─────────────────────────────────────────────────────────   │
│                                                               │
│  💨 Wind Speed                                               │
│  Min         Avg         Max                88,628 samples   │
│  1.1 m/s     7.2 m/s     22.5 m/s                            │
│                                                               │
│  ─────────────────────────────────────────────────────────   │
│                                                               │
│  🧭 Most Common Wind Direction                               │
│  WNW                                                          │
│  292.5°                    30,283 observations               │
│                                                               │
│  ─────────────────────────────────────────────────────────   │
│                                                               │
│  ⏰ Observation Period                                       │
│  00:00 UTC → 23:59 UTC                                       │
└─────────────────────────────────────────────────────────────┘
```

## Key Design Features

### 1. Visual Hierarchy
- **Sol number** (headline) and **Date** (caption) prominently displayed
- **Season badge** with orange background for visual prominence
- **Section dividers** separate different data types

### 2. Information Organization
- Data grouped by type (Temperature, Pressure, Wind)
- Consistent layout: Min | Avg | Max + Sample Count
- Average values highlighted in blue for emphasis

### 3. Contextual Information
- Hemispheric seasons show Mars' unique characteristics
- Sample counts provide data reliability context
- Wind direction includes both compass point and degrees
- Observation period shows temporal coverage

### 4. Data Presentation
- Temperature in Celsius (°C)
- Pressure in Pascals (Pa)
- Wind speed in meters per second (m/s) with 1 decimal place
- Wind direction in degrees with compass abbreviation

### 5. Accessibility
- SF Symbols icons for visual cues
- Color coding (blue for averages, orange/blue for hemispheres)
- Clear labels and units for all values
- Proper spacing for readability

## Comparison: Old vs New

### Old Display (Simple):
```
Sol 4012          Month 6
2024-10-15

Temperature
-89°C to -18°C

Pressure          Wind Speed
750 Pa            12 m/s
```

### New Display (Detailed):
```
Sol 4012                        Fall
2024-10-15                    Month 10

North: early winter   South: early summer

Temperature                   177,556 samples
Min: -97°C   Avg: -62°C   Max: -16°C

Pressure                      887,776 samples
Min: 722 Pa   Avg: 751 Pa   Max: 769 Pa

Wind Speed                     88,628 samples
Min: 1.1 m/s   Avg: 7.2 m/s   Max: 22.5 m/s

Most Common Wind Direction
WNW (292.5°)                  30,283 observations

Observation Period
00:00 UTC → 23:59 UTC
```

The new display provides significantly more detail while maintaining a clean, organized appearance that's easy to scan and understand.
