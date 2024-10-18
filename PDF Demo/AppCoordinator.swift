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
        showPDFReader(withDocumentNamed: "thinkos")
    }

    
    func showPDFReader(withDocumentNamed documentName: String) {
        
        let pdfReaderViewController = PDFReaderViewController()
        pdfReaderViewController.documentName = documentName
        
        navigationController.pushViewController(pdfReaderViewController, animated: true)
    }
}
