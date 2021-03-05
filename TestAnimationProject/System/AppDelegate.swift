//
//  AppDelegate.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
       
        return true
    }




}

