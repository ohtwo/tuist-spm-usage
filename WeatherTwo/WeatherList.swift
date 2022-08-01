//
//  WeatherList.swift
//  WeatherTwo
//
//  Created by Kang Byeonghak on 2022/07/29.
//

import SwiftUI
import SwiftDate

struct WeatherList: View {
  @StateObject private var weathers = WeatherVM()
  
  init() {
    SwiftDate.defaultRegion = Region.local
  }
  
  var body: some View {
    List() {
      ForEach(weathers.forecasts) { forecast in
        Section(header: Text(forecast.city.name)) {
          ForEach(forecast.weathers, id: \.self) { weather in
            WeatherCell(weather: weather)
          }
        }
      }
    }
    .listStyle(.insetGrouped)
    .environment(\.defaultMinListRowHeight, 45)
    .onAppear(perform: weathers.fetch)
  }
}
