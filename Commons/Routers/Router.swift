//
//  HttpRouter.swift
//  WeatherApp
//
//  Created by Kang Byeonghak on 2022/07/29.
//

import Foundation
import Alamofire

enum Router {
  static let apiKey = "ebd5210893e1263d8eedf4e094b817ee"
  static let host = "https://api.openweathermap.org"
}

extension HttpRoutable {
  var host: String {
    return Router.host
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var headers: HTTPHeaders? {
    return nil
  }
    
  var encoder: ParameterEncoding {
    return URLEncoding.default
  }
}

