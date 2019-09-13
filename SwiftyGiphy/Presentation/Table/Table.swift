//
//  Table.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 08/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import UIKit


final class Table {
    let tableView = UITableView()
    private var delegate = Delegate()
    
    init(cellInfo: [CellInfo]) {
        registerCells(cellInfo: cellInfo)
        tableView.dataSource = delegate
        tableView.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: TableModel) {
        delegate.model = model
        tableView.reloadData()
    }
    
    func addScrollEvents(_ scrollEvents: ScrollEvents) {
        delegate.scrollEvents.append(scrollEvents)
    }
    
    private func registerCells(cellInfo: [CellInfo]) {
        var registeredID = [String]()
        
        cellInfo.forEach { info in
            guard !registeredID.contains(info.reuseIdentifier) else {
                return
            }
            
            tableView.register(info.cellType, forCellReuseIdentifier: info.reuseIdentifier)
            registeredID.append(info.reuseIdentifier)
        }
    }
}

private final class Delegate: NSObject {
    var model: TableModel?
    var scrollEvents = [ScrollEvents]()
}

extension Delegate: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.numberOfRows(InSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configurator = model?[indexPath] else {
            return UITableViewCell()
        }
        
        let identifier = configurator.reuseID
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configurator.configureCell(cell, indexPath, tableView)
        
        return cell
    }
}

extension Delegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model?[indexPath].didSelect(indexPath, tableView)
    }
}

extension Delegate: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollEvents.forEach { $0.didScroll(scrollView) }
    }
}

