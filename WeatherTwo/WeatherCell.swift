//
//  WeatherCell.swift
//  WeatherTwo
//
//  Created by Kang Byeonghak on 2022/08/02.
//

import SwiftUI
import SwiftDate
import Kingfisher

struct WeatherCell: View {
  let weather: Forecast.Weather
  let url: URL?
  
  init(weather: Forecast.Weather) {
    self.weather = weather
    self.url = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")
  }
  
  var body: some View {
    HStack {
      KFImage(url)
        .cancelOnDisappear(true)
        .resizable()
        .frame(width: 45, height: 45)
      VStack(alignment: .leading) {
        Text("\(weather.main) \(weather.date.toFormat("M.d(E)"))")
        Text("\(weather.description) \(Int(weather.tempMin))°/\(Int(weather.tempMax))°")
          .font(.caption)
      }
    }
  }
}
