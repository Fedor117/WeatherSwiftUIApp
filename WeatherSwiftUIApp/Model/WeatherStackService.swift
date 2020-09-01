//
//  WeatherStackService.swift
//  WeatherSwiftUIApp
//
//  Created by Fedor Valiavko on 01/09/2020.
//  Copyright © 2020 Fedor Valiavko. All rights reserved.
//

import Foundation

final class WeatherStackService: WeatherServicing {
  enum Units: String {
    case metric = "m"
    case scientific = "s"
    case fahrenheit = "f"
  }
  
  private let decoder = JSONDecoder()
  
  func fetchWeatherData(for city: String, completionHandler: @escaping (Result<String, WeatherServicingError>) -> Void) {
    let endPoint = "https://api.weatherstack.com/current?access_key=\(APIKeys.weatherStack)&query=\(city)&units=\(Units.metric.rawValue)"
    
    guard let safeUrlString = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let endPointUrl = URL(string: safeUrlString) else {
      completionHandler(.failure(.invalidUrl(endPoint)))
      return
    }
    
    let dataTask = URLSession.shared.dataTask(with: endPointUrl) {
      [weak self] data, response, error in
      guard let self = self else { return }
      
      guard error == nil else {
        completionHandler(.failure(.forwarded(error!)))
        return
      }
      
      guard let responseData = data else {
        completionHandler(.failure(.invalidPayload(endPointUrl)))
        return
      }
      
      do {
        let weatherContainer = try self.decoder.decode(WeatherStackContainer.self, from: responseData)
        
        guard let weatherInfo = weatherContainer.current,
              let weather = weatherInfo.weather_descriptions?.first,
              let temperature = weatherInfo.temperature else {
          completionHandler(.failure(.invalidPayload(endPointUrl)))
          return
        }

        let weatherDescription = "\(weather) \(temperature) °C"
        completionHandler(.success(weatherDescription))

      } catch let error {
        completionHandler(.failure(.forwarded(error)))
      }
    }
    dataTask.resume()
  }
}
