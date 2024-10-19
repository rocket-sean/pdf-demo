//
//  Documents.swift
//  PDF Demo
//
//  Created by Sean Buttinger (Rocket Apes) on 18.10.24.
//

import Foundation


struct Document: Decodable, Hashable {
    
    public var id: Int
    public var name: String
    public var title: String
}


struct Documents: Decodable {
    
    public var documents: [Document]
     
    
    static let all: [Document] = loadDocuments(fromFileNamed: "documents") ?? []

    static var count: Int { all.count }
    
    
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
            let jsonData = try decoder.decode(Documents.self, from: data)

            return jsonData.documents
        } catch {
            print(error)
            
            return nil
        }
    }
}
