//
//  CellConfigurator.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 08/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import UIKit


struct CellInfo {
    let reuseIdentifier: String
    let cellType: AnyClass
}


protocol TableCellConfigurator {
    var reuseID: String { get }
    var configureCell: (UITableViewCell, IndexPath, UITableView) -> Void { get }
    var didSelect: (IndexPath, UITableView) -> Void { get }
}


struct CellDataConfigurator<Cell: UITableViewCell> {
    let reuseID: String
    let configure: (Cell, IndexPath, UITableView) -> Void
    let didSelect: (IndexPath, UITableView) -> Void
}


extension CellDataConfigurator: TableCellConfigurator {
    var configureCell: (UITableViewCell, IndexPath, UITableView) -> Void {
        return { cell, indexPath, tableView in
            guard let cell = cell as? Cell else { return }
            self.configure(cell, indexPath, tableView)
        }
    }
}


extension CellDataConfigurator {
    static func create<Cell, Model>(
        from configurator: CellConfigurator<Cell, Model>,
        model: Model
        ) -> CellDataConfigurator<Cell> {
        return CellDataConfigurator<Cell>(
            reuseID: configurator.cellInfo.reuseIdentifier,
            configure: { cell, indexPath, tableView in configurator.configure(cell, model, indexPath, tableView) },
            didSelect: { indexPath, tableView in configurator.didSelect(model, indexPath, tableView) }
        )
    }
}


struct CellConfigurator<Cell: UITableViewCell, Model> {
    let cellInfo: CellInfo
    let configure: (Cell, Model, IndexPath, UITableView) -> Void
    let didSelect: (Model, IndexPath, UITableView) -> Void
    
    init(
        configure: @escaping (Cell, Model, IndexPath, UITableView) -> Void,
        didSelect: @escaping (Model, IndexPath, UITableView) -> Void = {_,_,_ in }
        ) {
        self.cellInfo = CellInfo(reuseIdentifier: "\(Cell.self)-\(Model.self)", cellType: Cell.self)
        self.configure = configure
        self.didSelect = didSelect
    }
}
