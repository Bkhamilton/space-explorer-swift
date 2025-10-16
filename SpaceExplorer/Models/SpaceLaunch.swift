import Foundation

struct SpaceLaunch: Identifiable {
    let id = UUID()
    let name: String
    let agency: String
    let launchDate: String
    let location: String
    let missionType: String
    let status: String
}

// Hardcoded sample data
extension SpaceLaunch {
    static let sampleData: [SpaceLaunch] = [
        SpaceLaunch(
            name: "Falcon 9 - Starlink Group 6-25",
            agency: "SpaceX",
            launchDate: "2024-10-20",
            location: "Cape Canaveral, FL",
            missionType: "Communications",
            status: "Scheduled"
        ),
        SpaceLaunch(
            name: "Artemis II",
            agency: "NASA",
            launchDate: "2025-09-01",
            location: "Kennedy Space Center, FL",
            missionType: "Crewed Lunar Flyby",
            status: "Scheduled"
        ),
        SpaceLaunch(
            name: "JUICE - Jupiter Icy Moons Explorer",
            agency: "ESA",
            launchDate: "2023-04-14",
            location: "Kourou, French Guiana",
            missionType: "Planetary Exploration",
            status: "Launched"
        ),
        SpaceLaunch(
            name: "Chandrayaan-3",
            agency: "ISRO",
            launchDate: "2023-07-14",
            location: "Satish Dhawan Space Centre",
            missionType: "Lunar Landing",
            status: "Launched"
        ),
        SpaceLaunch(
            name: "New Glenn - First Flight",
            agency: "Blue Origin",
            launchDate: "2024-12-01",
            location: "Cape Canaveral, FL",
            missionType: "Test Flight",
            status: "Scheduled"
        ),
        SpaceLaunch(
            name: "Crew Dragon - Crew-8",
            agency: "SpaceX",
            launchDate: "2024-11-15",
            location: "Kennedy Space Center, FL",
            missionType: "ISS Crew Transport",
            status: "Scheduled"
        )
    ]
}
