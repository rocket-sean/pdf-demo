//
//  DocumentListViewController.swift
//  PDF Demo
//
//  Created by Sean Buttinger (Rocket Apes) on 18.10.24.
//

import UIKit

class DocumentListViewController: UIViewController {
    
    var coordinator: AppCoordinator?
    
    var contentView: DocumentListView {
        view as! DocumentListView
    }
    
    
    override func loadView() {
        view = DocumentListView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Documents.count > 0 ? "Documents" : "No Documents"
        
        navigationItem.backButtonTitle = ""
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.tableView.reloadData()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectionIndexPath = contentView.tableView.indexPathForSelectedRow {
            contentView.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }

}

    
extension DocumentListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Documents.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let document = Documents.all[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = document.title
        
        return cell
    }
}


extension DocumentListViewController: UITableViewDelegate {
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let document = Documents.all[indexPath.row]
        
        coordinator?.showDocumentReader(withDocumentId: document.id)
    }
}
