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
  
  var body: some View {
    VStack {
      TextField("Enter city", text: $input)
        .font(.title)
      
      Divider()

      Text(input)
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
