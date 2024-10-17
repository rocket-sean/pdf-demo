//
//  ViewController.swift
//  PDF Demo
//
//  Created by Sean Buttinger (Rocket Apes) on 17.10.24.
//

import UIKit
import PDFKit


class PDFReaderViewController: UIViewController {
    
    var pdfView: PDFView!
    
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    
    override func loadView() {
        
        view = UIView()
        
        pdfView = PDFView()
        pdfView.backgroundColor = .white
        pdfView.autoScales = true
        pdfView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(pdfView)
        
        NSLayoutConstraint.activate([
            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pdfView.topAnchor.constraint(equalTo: view.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePDFViewPageChangedNotification(notification:)),
            name: Notification.Name.PDFViewPageChanged,
            object: pdfView)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePDFViewSelectionChangedNotification(notification:)),
            name: Notification.Name.PDFViewSelectionChanged,
            object: pdfView)
        
        pdfView.document = loadDocument(named: "thinkos")
    }
    
    
    private func loadDocument(named name: String) -> PDFDocument? {
        
        guard let path = Bundle.main.url(forResource: name, withExtension: "pdf"),
              let document = PDFDocument(url: path) else {
            return nil
        }
        
        return document
    }
    
    
    @objc private func handlePDFViewPageChangedNotification(notification: Notification) {
        
        if let pageNumber = pdfView.document?.index(for: pdfView.currentPage!) {
            print("PAGE: \(pageNumber)")
        }
    }
        
    
    @objc private func handlePDFViewSelectionChangedNotification(notification: Notification) {

        if let selectedText = pdfView.currentSelection?.string {
            print("SELECTION: \(selectedText)")
        }
    }
}
