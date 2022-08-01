//
//  HttpClient+RxAPIs.swift
//  WeatherOne
//
//  Created by Kang Byeonghak on 2022/08/01.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import SwiftDate

extension HttpClient {
  static func fetchWeathers(of city: String) -> Observable<Forecast> {
    // Geocoding API
    let route = Router.Geo.direct(name: city)
    
    let coordinate = Observable.just(route)
      .flatMap({ route -> Observable<(HTTPURLResponse, [Location])> in
        HttpClient.request(route).rx.responseDecodable()
      })
      .compactMap({ $0.1.first?.coordinate })
      .share()
    
    // Current weather data
    let current = coordinate
      .map({ Router.Weather.current(coordinate: $0) })
      .flatMap({ route -> Observable<(HTTPURLResponse, Forecast.Weather)> in
        HttpClient.request(route).rx.responseDecodable()
      })
      .map({ $0.1 })
    
    // 5 day weather forecast
    let forecast = coordinate
      .map({ Router.Weather.forecast(coordinate: $0) })
      .flatMap({ route -> Observable<(HTTPURLResponse, Forecast)> in
        HttpClient.request(route).rx.responseDecodable()
      })
      .map({ $0.1 })
    
    let combined = current
      .flatMap({ current -> Observable<Forecast> in
        forecast.map { forecast in
          Forecast(city: forecast.city, weathers: [current]+forecast.weathers)
        }
      })
    
    return combined.flatMap({ forecast -> Observable<Forecast> in
      var weathers: [Forecast.Weather] = []
      
      for item in forecast.weathers {
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
      
      let result = Forecast(city: forecast.city, weathers: weathers)
      return Observable.of(result)
    })
    .take(6)
    .debug()
  }
}
