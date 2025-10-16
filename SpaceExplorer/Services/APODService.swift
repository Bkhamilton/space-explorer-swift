import Foundation

// MARK: - APOD Response Model
struct APODResponse: Codable {
    let date: String
    let explanation: String
    let title: String
    let url: String?
    let hdurl: String?
    let mediaType: String?
    
    enum CodingKeys: String, CodingKey {
        case date, explanation, title, url, hdurl
        case mediaType = "media_type"
    }
}

// MARK: - APOD Service
class APODService {
    static let shared = APODService()
    
    private init() {}
    
    func fetchAPOD(completion: @escaping (Result<APODResponse, Error>) -> Void) {
        let apiKey = APIConfiguration.nasaAPIKey
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)") else {
            completion(.failure(NSError(domain: "APODService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "APODService", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let apodResponse = try JSONDecoder().decode(APODResponse.self, from: data)
                completion(.success(apodResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchMultipleAPODs(count: Int = 5, completion: @escaping (Result<[APODResponse], Error>) -> Void) {
        let apiKey = APIConfiguration.nasaAPIKey
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&count=\(count)") else {
            completion(.failure(NSError(domain: "APODService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "APODService", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let apodResponses = try JSONDecoder().decode([APODResponse].self, from: data)
                completion(.success(apodResponses))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
