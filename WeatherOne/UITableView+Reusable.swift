//
//  UITableView+Reusable.swift
//  WeatherOne
//
//  Created by Kang Byeonghak on 2022/08/01.
//

import UIKit

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableView {
  func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
    register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
  }

  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
    }
    return cell
  }
}
