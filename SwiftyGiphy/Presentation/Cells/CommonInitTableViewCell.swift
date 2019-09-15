//
//  CommonInitTableViewCell.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 13/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import UIKit


class CommonInitTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        // point to override
    }
}
