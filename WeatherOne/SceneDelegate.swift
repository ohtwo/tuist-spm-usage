//
//  SceneDelegate.swift
//  WeatherOne
//
//  Created by Kang Byeonghak on 2022/07/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: scene)
    window?.rootViewController = WeatherListViewController(style: .insetGrouped)
    window?.makeKeyAndVisible()
  }
}

