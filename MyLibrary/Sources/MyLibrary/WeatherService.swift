import Alamofire
import Foundation

public protocol WeatherService {
    func getTemperature(url: WeatherServiceUrls) async throws -> Int
}

public enum WeatherServiceUrls: String {
    case OpenWeatherAPI = "https://api.openweathermap.org/data/2.5/weather?q=corvallis&units=imperial&appid=<YOUR API KEY HERE>"
    case MockServer = "http://localhost:3000/data/2.5/weather"
}

class WeatherServiceImpl: WeatherService {    
    
    func getTemperature(url: WeatherServiceUrls) async throws -> Int {
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url.rawValue, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
