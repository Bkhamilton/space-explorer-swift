import Foundation

struct APODResponse: Codable {
    let date: String
    let explanation: String
    let hdurl: String?
    let mediaType: MediaType
    let serviceVersion: String?
    let title: String
    let url: String?

    enum MediaType: String, Codable {
        case image
        case video
        case other
    }

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }

    // Fallback decoding so unknown media_type doesn't fail decoding
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        date = try c.decode(String.self, forKey: .date)
        explanation = try c.decode(String.self, forKey: .explanation)
        hdurl = try c.decodeIfPresent(String.self, forKey: .hdurl)
        serviceVersion = try c.decodeIfPresent(String.self, forKey: .serviceVersion)
        title = try c.decode(String.self, forKey: .title)
        url = try c.decodeIfPresent(String.self, forKey: .url)

        if let mediaStr = try? c.decode(String.self, forKey: .mediaType),
           let m = MediaType(rawValue: mediaStr) {
            mediaType = m
        } else {
            mediaType = .other
        }
    }

    // Convenience: best available image URL (hdurl preferred)
    var imageURL: URL? {
        if let s = hdurl ?? url { return URL(string: s) }
        return nil
    }
}