//
//  HttpClient+Combine.swift
//  WeatherTwo
//
//  Created by Kang Byeonghak on 2022/08/02.
//

import Foundation
import SwiftDate
import Combine
import Alamofire

extension HttpClient {
  static func fetchWeathers(of city: String) -> AnyPublisher<Forecast, AFError> {
    // Geocoding API
    let route = Router.Geo.direct(name: city)
    
    let coordinate = HttpClient.request(route).publishDecodable(type: [Location].self)
      .value()
      .compactMap({ $0.first?.coordinate })
      .eraseToAnyPublisher()

    // Current weather data
    let current = coordinate
      .map({ Router.Weather.current(coordinate: $0) })
      .flatMap({
        HttpClient.request($0).publishDecodable(type: Forecast.Weather.self)
      })
      .compactMap({ $0.value })
      .eraseToAnyPublisher()
    
    // 5 day weather forecast
    let forecast = coordinate
      .map({ Router.Weather.forecast(coordinate: $0) })
      .flatMap({
        HttpClient.request($0).publishDecodable(type: Forecast.self)
      })
      .compactMap({ $0.value })
      .eraseToAnyPublisher()
    
    
    // Lint weather data
    return current
      .flatMap({ current in
        forecast.map({
          Forecast(city: $0.city, weathers: [current]+$0.weathers)
        })
      })
      .map({ $0.lintData() })
      .prefix(6)
      .eraseToAnyPublisher()
  }
}
