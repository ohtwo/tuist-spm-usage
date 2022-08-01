//
//  Forecast.swift
//  WeatherApp
//
//  Created by Kang Byeonghak on 2022/07/31.
//

import Foundation

struct Forecast: Decodable, Identifiable {
  let id = UUID()
  
  let city: City
  let weathers: [Weather]
}

extension Forecast {
  private enum CodingKeys: String, CodingKey {
    case city
    case weathers = "list"
  }
}

extension Forecast {
  struct City: Decodable {
    let name: String
    let country: String
  }
  
  struct Weather: Decodable, Hashable, Identifiable {
    let id = UUID()
    
    let main: String
    let description: String
    let icon: String
    
    let temp: Double
    var tempMin: Double
    var tempMax: Double
    
    let date: Date
  }
}

extension Forecast.Weather {
  private enum CodingKeys: String, CodingKey {
    case weather
    case main
    case dt
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let weather: [[String: Any]] = try container.decode(Array<Any>.self, forKey: .weather) as! [[String: Any]]
    main = (weather.first?["main"] as? String) ?? ""
    description = (weather.first?["description"] as? String) ?? ""
    icon = (weather.first?["icon"] as? String) ?? ""
    
    let main = try container.decode([String: Double].self, forKey: .main)
    temp = main["temp"] ?? 0
    tempMin = main["temp_min"] ?? 0
    tempMax = main["temp_max"] ?? 0
    
    let dt = try container.decode(Double.self, forKey: .dt)
    date = Date(timeIntervalSince1970: dt)
  }
}

extension Forecast.Weather {
  var dateString : String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    
//    return date.formatted(date: .complete, time: .complete)
    return formatter.localizedString(for: date, relativeTo: .now)
  }
}

extension Forecast {
  func lintData() -> Forecast {
    var weathers: [Forecast.Weather] = []
    
    for item in self.weathers {
      guard let last = weathers.last else {
        weathers.append(item)
        continue
      }
      guard item.date.toString(.date(.medium)) != last.date.toString(.date(.medium)) else {
        var temp = last
        temp.tempMin = min(item.tempMin, last.tempMin)
        temp.tempMax = max(item.tempMax, last.tempMax)
        
        let count = weathers.count
        weathers[count-1] = temp
        continue
      }
      
      var temp = item
      temp.tempMin = min(item.tempMin, last.tempMin)
      temp.tempMax = max(item.tempMax, last.tempMax)
      
      weathers.append(temp)
    }
    
    let result = Forecast(city: self.city, weathers: weathers)
    return result
  }
}
