//
//  WeatherListViewController.swift
//  WeatherOne
//
//  Created by Kang Byeonghak on 2022/07/29.
//

import UIKit
import Alamofire
import RxSwift
import RxAlamofire

class WeatherListViewController: UITableViewController {

  var forecasts: [Forecast] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  let cities: [String] = ["Seoul", "London", "Chicago"]
  
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupTable()
    fetchWethers()
  }
}

extension WeatherListViewController {
  func setupTable() {
    tableView.register(WeatherListCell.self)
    tableView.allowsSelection = false
  }
  
  func fetchWethers() {
    let request = Observable.from(cities)
      .flatMap({ HttpClient.fetchWeathers(of: $0) })
      .buffer(timeSpan: .never, count: cities.count, scheduler: MainScheduler.instance)
      .take(1)
    
    request.subscribe(onNext: { [weak self] result in
      guard let self = self else { return }
      self.forecasts = result
    }).disposed(by: disposeBag)
  }
}

extension WeatherListViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return forecasts.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return forecasts[section].weathers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as WeatherListCell
    
    let weather = forecasts[indexPath.section].weathers[indexPath.row]
    cell.configure(with: weather)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return forecasts[section].city.name
  }
}
