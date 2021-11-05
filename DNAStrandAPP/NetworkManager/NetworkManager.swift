//
//  NetworkManager.swift
//  GitUsers
//
//  Created by Djallil Elkebir on 2021-09-28.
//

import Foundation

enum Gene: String, CaseIterable {
    case Insulin
    case Titin
    case Vasopressin
    case Prolactin
    case CReactiveProtein
    case Erythropoietin
    case ParathyroidHormone
    case Leptin
    case Glucagon
    case Calcitonin
    
    var urlAddition: String {
        switch self {
        case .Insulin:
            return "Insulin"
        case .Titin:
            return "Titin"
        case .Vasopressin:
            return "Vasopressin"
        case .Prolactin:
            return "Prolactin"
        case .CReactiveProtein:
            return "C-reactive%20protein"
        case .Erythropoietin:
            return "Erythropoietin"
        case .ParathyroidHormone:
            return "Parathyroid%20hormone"
        case .Leptin:
            return "Leptin"
        case .Glucagon:
            return "Glucagon"
        case .Calcitonin:
            return "Calcitonin"
        }
    }
}
class NetworkManager {
    static let shared = NetworkManager() // Shared Singelton
    
    private init() {}
    
    private let baseURL = ""
    private let session = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    
    func getGene(gene: Gene) async throws -> WikiAPIResult? {
        guard let url = generateGeneURL(gene: gene) else {
            return nil
        }
        print(url)
        
        let (data, _) = try await session.data(from: url)
        guard let gene: WikiAPIResult = try? jsonDecoder.decode(WikiAPIResult.self, from: data) else {
            return nil
        }
        return gene
    }
}


extension NetworkManager {
    // MARK: - URL Generator -
    private func generateGeneURL(gene: Gene)-> URL?{
        let url = "https://en.wikipedia.org/w/api.php?format=json&utf8=1&action=query&prop=pageimages%7Cinfo%7Cextracts&titles=\(gene.urlAddition)"
        return URL(string: url)
    }
   
}
