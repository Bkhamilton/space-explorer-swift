import Foundation

struct SpacePicture: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    let date: String
    
    // Initialize from APOD API response
    init(title: String, description: String, imageName: String, date: String) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.date = date
    }
    
    // Create SpacePicture from APODResponse
    init(from apod: APODResponse) {
        self.title = apod.title
        self.description = apod.explanation
        self.imageName = "photo" // Default SF Symbol for pictures from API
        self.date = apod.date
    }
}

// Hardcoded sample data
extension SpacePicture {
    static let sampleData: [SpacePicture] = [
        SpacePicture(
            title: "Andromeda Galaxy",
            description: "The Andromeda Galaxy is a barred spiral galaxy and is the nearest major galaxy to the Milky Way.",
            imageName: "star.fill",
            date: "2024-10-15"
        ),
        SpacePicture(
            title: "Eagle Nebula",
            description: "The Eagle Nebula is a young open cluster of stars in the constellation Serpens, discovered by Jean-Philippe de Cheseaux in 1745-46.",
            imageName: "sparkles",
            date: "2024-10-14"
        ),
        SpacePicture(
            title: "Hubble Deep Field",
            description: "An image of a small region in the constellation Ursa Major, constructed from a series of observations by the Hubble Space Telescope.",
            imageName: "square.grid.3x3.fill",
            date: "2024-10-13"
        ),
        SpacePicture(
            title: "Jupiter's Great Red Spot",
            description: "A persistent high-pressure region in the atmosphere of Jupiter, producing an anticyclonic storm.",
            imageName: "circle.fill",
            date: "2024-10-12"
        ),
        SpacePicture(
            title: "Saturn's Rings",
            description: "Saturn's rings are made of billions of pieces of ice, rock and dust, some as small as a grain of sand.",
            imageName: "circle.circle.fill",
            date: "2024-10-11"
        )
    ]
}
