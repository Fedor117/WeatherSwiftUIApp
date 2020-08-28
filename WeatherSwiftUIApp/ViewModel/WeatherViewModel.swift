//
//  WeatherViewModel.swift
//  WeatherSwiftUIApp
//
//  Created by Fedor Valiavko on 28/08/2020.
//  Copyright © 2020 Fedor Valiavko. All rights reserved.
//

import Foundation

final class WeatherViewModel: ObservableObject {
  @Published var weatherInfo = ""
  
  private let service: WeatherServicing
  
  init(service: WeatherServicing) {
    self.service = service
  }
  
  func fetchWeather(for city: String) {
    service.fetchWeatherData(for: city) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let description):
        DispatchQueue.main.async {
          self.weatherInfo = description
        }

      case .failure(_):
        DispatchQueue.main.async {
          self.weatherInfo = "Could not fetch weather information for \(city)"
        }
      }
    }
  }
}
