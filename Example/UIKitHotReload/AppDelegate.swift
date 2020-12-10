//
//  AppDelegate.swift
//  UIKitHotReload
//
//  Created by sakiyama.k@gmail.com on 11/13/2020.
//  Copyright (c) 2020 sakiyama.k@gmail.com. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    window = UIWindow(frame: UIScreen.main.bounds)
    let root = UINavigationController(rootViewController: MainViewController())
    window?.rootViewController = root
    window?.makeKeyAndVisible()
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }
}
