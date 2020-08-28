//
//  OpenWeatherMapData.swift
//  WeatherSwiftUIApp
//
//  Created by Fedor Valiavko on 28/08/2020.
//  Copyright © 2020 Fedor Valiavko. All rights reserved.
//

import Foundation

struct OpenWeatherMapContainer: Codable {
  let list: [OpenWeatherMapData]
}

struct OpenWeatherMapData: Codable {
  let weather: [OpenWeatherMapWeather]
  let main: OpenWeatherMapMain
}

struct OpenWeatherMapWeather: Codable {
  let id: Int
  let main: String
  let description: String
  let icon: String
}

struct OpenWeatherMapMain: Codable {
  let temp: Float
}
