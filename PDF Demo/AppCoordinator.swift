//
//  AppCoordinator.swift
//  PDF Demo
//
//  Created by Sean Buttinger (Rocket Apes) on 18.10.24.
//

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}


class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.tintColor = UIColor.darkGray
    }

    
    func start() {
        showDocumentList()
    }

    
    func showDocumentList() {
        
        let documentListViewController = DocumentListViewController()
        documentListViewController.coordinator = self
        
        navigationController.pushViewController(documentListViewController, animated: true)
    }

    
    func showDocumentReader(withDocumentId documentId: Int) {
        
        let documentReaderViewController = DocumentReaderViewController()
        documentReaderViewController.coordinator = self
        
        documentReaderViewController.documentId = documentId
        
        navigationController.pushViewController(documentReaderViewController, animated: true)
    }
}
