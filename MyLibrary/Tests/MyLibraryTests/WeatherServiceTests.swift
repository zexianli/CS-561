import XCTest
@testable import MyLibrary

final class WeatherServiceTests: XCTestCase {
    
    let apiRes = """
    {
       "coord":{
          "lon":-123.262,
          "lat":44.5646
       },
       "weather":[
          {
             "id":800,
             "main":"Clear",
             "description":"clear sky",
             "icon":"01d"
          }
       ],
       "base":"stations",
       "main":{
          "temp":53.28,
          "feels_like":52.25,
          "temp_min":43.27,
          "temp_max":60.08,
          "pressure":1015,
          "humidity":84
       },
       "visibility":10000,
       "wind":{
          "speed":2.75,
          "deg":21,
          "gust":4.21
       },
       "clouds":{
          "all":2
       },
       "dt":1665761408,
       "sys":{
          "type":2,
          "id":2009551,
          "country":"US",
          "sunrise":1665757615,
          "sunset":1665797445
       },
       "timezone":-25200,
       "id":5720727,
       "name":"Corvallis",
       "cod":200
    }
    """
    func testWeatherModelDecodeValidData() throws {
        // Given
        let encodedData = Data(apiRes.utf8)
        
        // When
        let decodedData = try JSONDecoder().decode(Weather.self, from: encodedData)
        
        // Then
        XCTAssertNotNil(decodedData)
    }
    
    func testWeatherModelDecodeInvalidData() throws {
        // Given
        let encodedData = Data("This is invalid".utf8)
        
        // When
        let decodedData = try? JSONDecoder().decode(Weather.self, from: encodedData)
        
        // Then
        XCTAssertNil(decodedData)
    }
    
    
   //  func testWeatherServiceImplementationWithAPI() async throws {
   //      // Given
   //      let WeatherService = WeatherServiceImpl()

   //      // When
   //      let temperature = try await WeatherService.getTemperature(url : WeatherServiceUrls.OpenWeatherAPI)
        
   //      // Then
   //      XCTAssertNotNil(temperature)
    }
    
    func testWeatherServiceWithMockServer() async throws {
        // Given
        let WeatherService = WeatherServiceImpl()

        // When
        let temperature = try await WeatherService.getTemperature(url : WeatherServiceUrls.MockServer)
        
        // Then
        XCTAssertNotNil(temperature)
    }
    
}
