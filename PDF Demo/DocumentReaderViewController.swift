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

    var documentId: Int?
    
    
    var contentView: DocumentReaderView {
        view as! DocumentReaderView
    }
    
    override func loadView() {
        
        view = DocumentReaderView()
        
        contentView.pdfView.backgroundColor = .white
        contentView.pdfView.autoScales = true
        contentView.pdfView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePDFViewPageChangedNotification(notification:)),
            name: Notification.Name.PDFViewPageChanged,
            object: contentView.pdfView)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePDFViewSelectionChangedNotification(notification:)),
            name: Notification.Name.PDFViewSelectionChanged,
            object: contentView.pdfView)
        
        guard let documentId = documentId,
              let document = DocumentStore.shared.documentForId(documentId) else {
            title = "No Document"
            return
        }
        
        contentView.pdfView.document = loadPDFDocument(named: document.name)
        title = document.title
    }
    
    
    private func loadPDFDocument(named name: String) -> PDFDocument? {
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "pdf"),
              let pdfDocument = PDFDocument(url: url) else {
            return nil
        }
        
        return pdfDocument
    }
    
    
    @objc private func handlePDFViewPageChangedNotification(notification: Notification) {
        
        if let pageNumber = contentView.pdfView.document?.index(for: contentView.pdfView.currentPage!) {
            print("PAGE: \(pageNumber)")
        }
    }
        
    
    @objc private func handlePDFViewSelectionChangedNotification(notification: Notification) {

        if let selectedText = contentView.pdfView.currentSelection?.string {
            print("SELECTION: \(selectedText)")
        }
    }
}
