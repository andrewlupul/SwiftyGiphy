//
//  AppConfiguring.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 14/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import Foundation
import Nuke


protocol AppConfiguring {
    func configure()
}


final class AppConfiguringImpl: AppConfiguring {
    func configure() {
        setupNuke()
    }
    
    private func setupNuke() {
        ImagePipeline.Configuration.isAnimatedImageDataEnabled = true
    }
}

