//
//  WeatherStackData.swift
//  WeatherSwiftUIApp
//
//  Created by Fedor Valiavko on 01/09/2020.
//  Copyright © 2020 Fedor Valiavko. All rights reserved.
//

import Foundation

struct WeatherStackContainer: Codable {
  let current: WeatherStackCurrent?
}

struct WeatherStackCurrent: Codable {
  let temperature: Int?
  let weather_descriptions: [String]?
}

struct WeatherStackCondition: Codable {
  let text: String
  let icon: String
}
