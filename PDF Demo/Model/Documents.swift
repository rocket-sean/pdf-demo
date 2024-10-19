//
//  Documents.swift
//  PDF Demo
//
//  Created by Sean Buttinger (Rocket Apes) on 18.10.24.
//

import Foundation


struct Document: Decodable {
    
    let id: Int
    let name: String
    let title: String
}


struct Documents: Decodable {
    
    private let documents: [Document]
     
    
    static let all: [Document] = Documents().documents

    static var count: Int { all.count }
    
    
    private init() {
        documents = Self.loadDocuments(fromFileNamed: "documents") ?? []
    }
    
    
    static func documentForId(_ id: Int) -> Document? {
        return all.first(where: { $0.id == id })
    }
    
    
    private static func loadDocuments(fromFileNamed filename: String) -> [Document]? {
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Self.self, from: data)

            return jsonData.documents
        } catch {
            print(error)
            
            return nil
        }
    }
}
