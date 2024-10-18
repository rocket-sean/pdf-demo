//
//  DocumentReaderViewController.swift
//  PDF Demo
//
//  Created by Sean Buttinger (Rocket Apes) on 17.10.24.
//

import UIKit
import PDFKit


class DocumentReaderViewController: UIViewController {
    
    var coordinator: Coordinator?

    var documentName: String?
    private var documentView: PDFView!
    
    
    override func loadView() {
        
        view = UIView()
        
        documentView = PDFView()
        documentView.backgroundColor = .white
        documentView.autoScales = true
        documentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(documentView)
        
        NSLayoutConstraint.activate([
            documentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            documentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            documentView.topAnchor.constraint(equalTo: view.topAnchor),
            documentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePDFViewPageChangedNotification(notification:)),
            name: Notification.Name.PDFViewPageChanged,
            object: documentView)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePDFViewSelectionChangedNotification(notification:)),
            name: Notification.Name.PDFViewSelectionChanged,
            object: documentView)
        
        guard let documentName = documentName else {
            title = "Document Not Found"
            return
        }

        documentView.document = loadDocument(named: documentName)
        title = documentName + ".pdf"

    }
    
    
    private func loadDocument(named name: String) -> PDFDocument? {
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "pdf"),
              let document = PDFDocument(url: url) else {
            return nil
        }
        
        return document
    }
    
    
    @objc private func handlePDFViewPageChangedNotification(notification: Notification) {
        
        if let pageNumber = documentView.document?.index(for: documentView.currentPage!) {
            print("PAGE: \(pageNumber)")
        }
    }
        
    
    @objc private func handlePDFViewSelectionChangedNotification(notification: Notification) {

        if let selectedText = documentView.currentSelection?.string {
            print("SELECTION: \(selectedText)")
        }
    }
}
