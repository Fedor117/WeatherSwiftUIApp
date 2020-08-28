//
//  OpenWeatherMapService.swift
//  WeatherSwiftUIApp
//
//  Created by Fedor Valiavko on 28/08/2020.
//  Copyright © 2020 Fedor Valiavko. All rights reserved.
//

import Foundation

final class OpenWeatherMapService: WeatherServicing {
  private let decoder = JSONDecoder()
  
  func fetchWeatherData(for city: String, completionHandler: @escaping (Result<String, WeatherServicingError>) -> Void) {
    let endPoint = "https://api.openweathermap.org/data/2.5/find?q=\(city)&units=metric&appid=\(APIKeys.openWeatherMap.rawValue)"
    
    guard let safeUrlString = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let endpointUrl = URL(string: safeUrlString) else {
      completionHandler(.failure(.invalidUrl(endPoint)))
      return
    }
    
    let dataTask = URLSession.shared.dataTask(with: endpointUrl) {
      [weak self] data, response, error in
      guard let self = self else { return }
      
      guard error == nil else {
        completionHandler(.failure(.forwarded(error!)))
        return
      }
      
      guard let responseData = data else {
        completionHandler(.failure(.invalidPayload(endpointUrl)))
        return
      }
      
      do {
        let weatherList = try self.decoder.decode(OpenWeatherMapContainer.self, from: responseData)
        guard let weatherInfo = weatherList.list.first else {
          completionHandler(.failure(.invalidPayload(endpointUrl)))
          return
        }
        
        let weather = weatherInfo.weather.first!.main
        let temperature = weatherInfo.main.temp
        let weatherDescription = "\(String(describing: weather)) \(temperature)"
        completionHandler(.success(weatherDescription))
        
      } catch let error {
        completionHandler(.failure(.forwarded(error)))
      }
    }
    dataTask.resume()
  }
}
