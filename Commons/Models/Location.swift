//
//  Location.swift
//  WeatherApp
//
//  Created by Kang Byeonghak on 2022/07/30.
//

import Foundation

struct Location: Codable {
  let name: String
  let localNames: [String: String]
  let latitude: Double
  let longitude: Double
  let country: String
}

extension Location {
  enum CodingKey: String, Swift.CodingKey {
    case name
    case localNames   = "local_names"
    case latitude     = "lat"
    case longitude    = "lon"
    case country
  }
}

extension Location {
  typealias Coordinate = (latitude: Double, longitude: Double)
  
  var coordinate: Coordinate {
    return (latitude, longitude)
  }
}
