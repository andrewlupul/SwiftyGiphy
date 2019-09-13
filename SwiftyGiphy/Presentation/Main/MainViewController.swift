//
//  MainViewController.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 05/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import UIKit
import Nuke
import FLAnimatedImage
import SnapKit


protocol MainViewOutput: class {
    func cellModels() -> [GifCellModel]
    func set(viewInput: MainViewInput)
    func viewDidLoad()
    func didScrollAlmostToEnd()
}


protocol MainViewInput: class {
    func startLoading()
    func stopLoading()
    func show(error: String)
    func reloadData()
}


final class MainViewController: UIViewController {
    private let output: MainViewOutput
    private var collectionView: UICollectionView!
    
    private let imageCellReuseID = "imageCellReuseID"
    
    init(output: MainViewOutput) {
        self.output = output
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewDidLoad()
        setupLayout()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: imageCellReuseID)
        collectionView.alwaysBounceVertical = true
//        collectionView.layout.minimumLineSpacing = 0
//
//        collectionView.layout.sectionInset = UIEdgeInsets(top: 16,
//                                                          left: 16,
//                                                          bottom: 16,
//                                                          right: 16)
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.cellModels().count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return createCell(for: indexPath)
    }
    
    func createCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: imageCellReuseID,
            for: indexPath
            ) as? GifCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        
        cell.configureWith(cellModel: output.cellModels()[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
}


extension MainViewController: MainViewInput {
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
    
    func show(error: String) {
        
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
