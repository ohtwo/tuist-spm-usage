//
//  Router+Weather.swift
//  WeatherApp
//
//  Created by Kang Byeonghak on 2022/07/30.
//

import Foundation
import Alamofire

extension Router {
  enum Weather {
    case current(coordinate: Location.Coordinate)
    case forecast(coordinate: Location.Coordinate)
  }
}

extension Router.Weather {
  private var endpoint: String { return "data" }
  private var version: String { return "2.5" }
}

extension Router.Weather: HttpRoutable {
  var path: String {
    switch self {
    case .current:      return "/\(endpoint)/\(version)/weather"
    case .forecast:     return "/\(endpoint)/\(version)/forecast"
    }
  }
  
  var parameters: Parameters? {
    switch self {
    case .current(let coordinate), .forecast(let coordinate):
      return [
        "appid": Router.apiKey,
        "lat": coordinate.latitude,
        "lon": coordinate.longitude
      ]
    }
  }
}
