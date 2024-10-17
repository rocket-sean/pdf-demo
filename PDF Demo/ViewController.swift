//
//  ViewController.swift
//  PDF Demo
//
//  Created by Sean Buttinger (Rocket Apes) on 17.10.24.
//

import UIKit
import PDFKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfView = PDFView()
        pdfView.backgroundColor = .white
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
