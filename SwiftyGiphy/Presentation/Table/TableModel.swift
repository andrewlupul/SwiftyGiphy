//
//  TableModel.swift
//  SwiftyGiphy
//
//  Created by andrewlupul on 08/09/2019.
//  Copyright © 2019 andrewlupul. All rights reserved.
//

import UIKit


protocol TableModel {
    var isEmpty: Bool { get }
    func numberOfSections() -> Int
    func numberOfRows(InSection sectionIndex: Int) -> Int
    subscript(indexPath: IndexPath) -> TableCellConfigurator { get }
}


struct DefaultTableModel {
    var sections: [Section]
    
    init(sections: [Section]) {
        self.sections = sections
    }
    
    static func section(configurators: [TableCellConfigurator]) -> DefaultTableModel {
        return DefaultTableModel(sections: [Section(configurators: configurators)])
    }
}


struct Section {
    private(set) var configurators: [TableCellConfigurator]
}


extension DefaultTableModel: TableModel {
    var isEmpty: Bool {
        return sections.reduce(into: 0) { $0 += $1.configurators.count } == 0
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(InSection sectionIndex: Int) -> Int {
        return sections[sectionIndex].configurators.count
    }
    
    subscript(indexPath: IndexPath) -> TableCellConfigurator {
        return sections[indexPath.section].configurators[indexPath.row]
    }
}


struct ScrollEvents {
    let didScroll: (UIScrollView) -> Void
    
    init(didScroll: @escaping (UIScrollView) -> Void = { _ in }) {
        self.didScroll = didScroll
    }
}
