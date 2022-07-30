//
//  Router+Geo.swift
//  WeatherApp
//
//  Created by Kang Byeonghak on 2022/07/30.
//

import Foundation
import Alamofire

extension Router {
  enum Geo {
    case direct(name: String)
  }
}

extension Router.Geo {
  private var endpoint: String { return "geo" }
  private var version: String { return "1.0" }
}

extension Router.Geo: HttpRoutable {
  var path: String {
    return "/\(endpoint)/\(version)/direct"
  }
  
  var parameters: Parameters? {
    guard case let .direct(name) = self else { return nil }
    return [
      "appid": Router.apiKey,
      "q": name
    ]
  }
}
