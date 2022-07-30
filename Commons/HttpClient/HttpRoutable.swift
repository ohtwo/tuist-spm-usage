//
//  HttpRoutable.swift
//  WeatherApp
//
//  Created by Kang Byeonghak on 2022/07/30.
//

import Foundation
import Alamofire

protocol HttpRoutable: URLConvertible, URLRequestConvertible {
  var host: String { get }
  var method: HTTPMethod { get }
  var path: String { get }
  var headers: HTTPHeaders? { get }
  var parameters: Parameters? { get }
  var encoder: ParameterEncoding { get }
}

extension HttpRoutable {
  func asURL() throws -> URL {
    guard let url = URL(string: host)?.appendingPathComponent(path) else {
      throw AFError.invalidURL(url: host)
    }
    return url
  }
}

extension HttpRoutable {
  func asURLRequest() throws -> URLRequest {
    let url = try asURL()
    let request = try URLRequest(url: url, method: method, headers: headers)
    let encoded = try encoder.encode(request, with: parameters)
    
    return encoded
  }
}
