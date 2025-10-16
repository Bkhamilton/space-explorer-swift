import Foundation

struct APIConfiguration {
    static var nasaAPIKey: String {
        // Try to read from environment variable first
        if let key = ProcessInfo.processInfo.environment["NASA_API_KEY"], !key.isEmpty {
            return key
        }
        // Fallback to DEMO_KEY if environment variable is not set
        return "DEMO_KEY"
    }
}
