import Foundation

struct APIConfiguration {
    private static let infoPlistKey = "NASA_API_KEY"

    static var nasaAPIKey: String {
        // 1) Runtime environment variable (useful when launching from Xcode with a scheme env var)
        if let key = ProcessInfo.processInfo.environment["NASA_API_KEY"], !key.isEmpty {
            return key
        }

        // 2) Build-time injected value from Info.plist (e.g. set Info.plist value to $(NASA_API_KEY))
        if let infoKey = Bundle.main.object(forInfoDictionaryKey: infoPlistKey) as? String, !infoKey.isEmpty {
            return infoKey
        }

        // 3) Fallback to demo key (safe default for development/testing)
        return "DEMO_KEY"
    }
}
