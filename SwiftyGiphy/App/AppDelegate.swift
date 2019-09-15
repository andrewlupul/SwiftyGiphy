//
//  AppDelegate.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 05/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import UIKit
import Nuke

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let configurator = AppConfiguringImpl()
    
    private var coordinator = AppCoordinator(configurator: MainAssemblyDefault())
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configurator.configure()
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}

