//
//  DocumentListViewController.swift
//  PDF Demo
//
//  Created by Sean Buttinger (Rocket Apes) on 18.10.24.
//

import UIKit

class DocumentListViewController: UIViewController {
    
    var coordinator: AppCoordinator?
    
    var tableView: UITableView!
    

    override func loadView() {
        
        view = UIView()
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Documents"
        
        tableView.reloadData()
    }
    
    
    func loadDocuments() -> [Document]? {
        
        guard let url = Bundle.main.url(forResource: "documents", withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Documents.self, from: data)

            return jsonData.documents
        } catch {
            print(error)
            
            return nil
        }
    }
}


extension DocumentListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DocumentStore.shared.documents.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let document = DocumentStore.shared.documents[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = document.title
        
        return cell
    }
}


extension DocumentListViewController: UITableViewDelegate {
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let document = DocumentStore.shared.documents[indexPath.row]        
        coordinator?.showDocumentReader(withDocumentNamed: document.name)
    }
}
