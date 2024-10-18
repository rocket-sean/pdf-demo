//
//  DocumentListView.swift
//  PDF Demo
//
//  Created by Sean Buttinger (Rocket Apes) on 18.10.24.
//

import UIKit
    


class DocumentListView: UIView {
    
    let tableView: UITableView

    
    override init(frame: CGRect) {
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    

    required init?(coder: NSCoder) {
        fatalError()
    }
}
