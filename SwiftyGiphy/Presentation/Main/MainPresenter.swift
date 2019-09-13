//
//  MainPresenter.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 08/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import Foundation


final class MainPresenter {
    private let service: GiphyService
    private weak var viewInput: MainViewInput?
    private var gifDataArray: [GifData]?
    private var isLoading = false
    
    init(service: GiphyService) {
        self.service = service
    }
    
    private func loadData() {
        service.getTrends { [weak self] result in
            do {
                self?.gifDataArray = try result.get()
                self?.viewInput?.reloadData()
            } catch {
                // TODO:
                print(error.localizedDescription)
            }
        }
    }
}


extension MainPresenter: MainViewOutput {
    func cellModels() -> [GifCellModel] {
        return gifDataArray.map {
            $0.map { $0.asGifCellModel() }
        } ?? []
    }
    
    func set(viewInput: MainViewInput) {
        self.viewInput = viewInput
    }
    
    func viewDidLoad() {
        viewInput?.startLoading()
        loadData()
    }
    
    func didScrollAlmostToEnd() {
        
    }
}


extension GifData {
    func asGifCellModel() -> GifCellModel {
        // TODO: avoid force cast?
        return DefaultGifCellModel(gifUrl: URL(string: images.downsized.url)!)
    }
}
