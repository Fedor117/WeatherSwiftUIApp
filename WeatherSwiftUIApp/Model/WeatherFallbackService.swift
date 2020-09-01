//
//  WeatherFallbackService.swift
//  WeatherSwiftUIApp
//
//  Created by Fedor Valiavko on 01/09/2020.
//  Copyright © 2020 Fedor Valiavko. All rights reserved.
//

import Foundation

final class WeatherFallbackService: WeatherServicing {
  private var services: [WeatherServicing]
  
  convenience init() {
    self.init(services: [])
  }
  
  init(services: [WeatherServicing]) {
    self.services = services
  }
  
  func fetchWeatherData(for city: String, completionHandler: @escaping (Result<String, WeatherServicingError>) -> Void) {
    fetchWeatherData(serviceIdx: 0, for: city, completionHandler: completionHandler)
  }
  
  private func fetchWeatherData(serviceIdx: Int, for city: String, completionHandler: @escaping (Result<String, WeatherServicingError>) -> Void) {
    guard serviceIdx > -1, services.count > serviceIdx else {
      completionHandler(.failure(.servicesUnavailable("Weather services are not available right now.")))
      return
    }
    
    services[serviceIdx].fetchWeatherData(for: city) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let description):
        completionHandler(.success(description))
        
      case .failure(_):
        self.fetchWeatherData(serviceIdx: serviceIdx + 1, for: city, completionHandler: completionHandler)
      }
    }
  }
}
