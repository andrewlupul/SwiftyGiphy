//
//  AppCoordinator.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 08/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import UIKit


final class AppCoordinator {
    private(set) var rootController: UIViewController?
    private let configurator: MainAssembly
    
    init(configurator: MainAssembly) {
        self.configurator = configurator
        rootController = configurator.mainViewController()
    }
    
    func start() {
        UIApplication.shared.delegate?.window??.rootViewController = rootController
    }
}
