//
//  ContentView.swift
//  WeatherSwiftUIApp
//
//  Created by Fedor Valiavko on 28/08/2020.
//  Copyright © 2020 Fedor Valiavko. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var input: String = ""
  
  @ObservedObject var viewModel = WeatherViewModel(service: WeatherFallbackService(services: [WeatherStackService(), OpenWeatherMapService()]))
  
  var body: some View {
    VStack {
      TextField("Enter city",
                text: $input,
                onEditingChanged: { _ in
                  // do nothing
                }, onCommit: {
                  if !self.input.isEmpty {
                    self.viewModel.fetchWeather(for: self.input)
                  }
                })
        .font(.title)
      
      Divider()

      Text(viewModel.weatherInfo)
        .font(.body)
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {  
  static var previews: some View {
    ContentView()
  }
}
