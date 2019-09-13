//
//  MainAssembly.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 13/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import UIKit


protocol MainAssembly {
    func mainViewController() -> MainViewController
}


final class MainAssemblyDefault {
    private func createMainViewController() -> MainViewController {
        let api = createApi(networking: createNetworking())
        let output = MainPresenter(service: createService(api: api))
        
        let controller = MainViewController(output: output)
        output.set(viewInput: controller)
        
        return controller
    }
    
    private func createService(api: API) -> GiphyService {
        return GiphyServiceImpl(api: api)
    }
    
    private func createApi(networking: Networking) -> API {
        return GiphyAPI(networking: createNetworking())
    }
    
    private func createNetworking() -> Networking {
        return NetworkingImpl()
    }
}


extension MainAssemblyDefault: MainAssembly {
    func mainViewController() -> MainViewController {
        return createMainViewController()
    }
}
