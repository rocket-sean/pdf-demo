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
    }

    
    func start() {
        showDocumentReader(withDocumentNamed: "think-os")
    }

    
    func showDocumentReader(withDocumentNamed documentName: String) {
        
        let documentReaderViewController = DocumentReaderViewController()
        documentReaderViewController.coordinator = self
        
        documentReaderViewController.documentName = documentName
        
        navigationController.pushViewController(documentReaderViewController, animated: true)
    }
}
