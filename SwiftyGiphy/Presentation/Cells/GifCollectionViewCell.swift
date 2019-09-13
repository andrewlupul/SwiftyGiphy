//
//  GifCollectionViewCell.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 09/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import UIKit
import Nuke
import FLAnimatedImage


protocol GifCellModel {
    var gifUrl: URL { get }
}


struct DefaultGifCellModel: GifCellModel {
    let gifUrl: URL
}


final class GifCollectionViewCell: UICollectionViewCell {
    let imageView: FLAnimatedImageView
    let activityIndicator: UIActivityIndicatorView
    
    override init(frame: CGRect) {
        imageView = FLAnimatedImageView()
        activityIndicator = UIActivityIndicatorView(style: .gray)
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(white: 235.0 / 255.0, alpha: 1.0)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
        imageView.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
        
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.nuke_display(image: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func configureWith(cellModel: GifCellModel) {
        activityIndicator.startAnimating()
        
        loadImage(
            with: cellModel.gifUrl,
            options: ImageLoadingOptions(transition: .fadeIn(duration: 0.33)),
            into: imageView,
            completion: { [weak self] _ in
                self?.activityIndicator.stopAnimating()
            }
        )
    }
}
