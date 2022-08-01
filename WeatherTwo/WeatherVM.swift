//
//  WeatherVM.swift
//  WeatherTwo
//
//  Created by Kang Byeonghak on 2022/08/02.
//

import Foundation
import Combine

class WeatherVM: ObservableObject {
  @Published var forecasts: [Forecast] = []
  
  let cities: [String] = ["Seoul", "London", "Chicago"]
  var tokens: Set<AnyCancellable> = []
}

extension WeatherVM {
  func fetch(){
    let request = cities.publisher
      .flatMap({
        HttpClient.fetchWeathers(of: $0)
      })
      .collect(cities.count)
      .eraseToAnyPublisher()
    
    request.sink { _ in
      
    } receiveValue: { result in
      self.forecasts = result
      print(result)
    }
    .store(in: &tokens)
  }
}
