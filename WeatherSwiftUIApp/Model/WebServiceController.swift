//
//  WebServiceController.swift
//  WeatherSwiftUIApp
//
//  Created by Fedor Valiavko on 28/08/2020.
//  Copyright © 2020 Fedor Valiavko. All rights reserved.
//

import Foundation

enum WebServiceControllerError: Error {
  case invalidUrl(String)
  case invalidPayload(URL)
  case forwarded(Error)
}

protocol WeatherServicing {
  func fetchWeatherData(for city: String,
                        completionHandler: @escaping (Result<String, WebServiceControllerError>) -> Void)
}
