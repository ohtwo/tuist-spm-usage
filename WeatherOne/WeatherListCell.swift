//
//  WeatherListCell.swift
//  WeatherOne
//
//  Created by Kang Byeonghak on 2022/07/31.
//

import UIKit
import SwiftDate
import Kingfisher

class WeatherListCell: UITableViewCell, ReusableView {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    imageView?.kf.cancelDownloadTask()
    imageView?.kf.setImage(with: URL(string: ""))
    imageView?.image = nil
  }
  
  func configure(with weather: Forecast.Weather) {
    let url = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")
    imageView?.kf.setImage(with: url)
    imageView?.kf.setImage(with: url, completionHandler: { [weak self] result in
      guard let self = self else { return }
      guard case .success = result else { return }
      self.setNeedsLayout()
      self.layoutIfNeeded()
    })
    
    textLabel?.text = "\(weather.main) \(weather.date.toFormat("M.d(E)") )"
    detailTextLabel?.text = "\(weather.description) \(Int(weather.tempMin))°/\(Int(weather.tempMax))°"
  }
}
