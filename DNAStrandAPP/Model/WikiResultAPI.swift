//
//  WikiResultAPI.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-05.
//
// Model respresenting the result of the api call

import Foundation


struct WikiAPIResult: Codable {
    let batchcomplete: String
    let query: Query
}
// MARK: - Query
struct Query: Codable {
    let pages: Pages
}

// MARK: - Pages
struct Pages: Codable {
    var resultData: WikiData

    private struct DynamicCodingKeys: CodingKey {
            // Use for string-keyed dictionary
            var stringValue: String
            init?(stringValue: String) {
                self.stringValue = stringValue
            }
            // Necessary to conform to CodingKeys but we are not using it
            var intValue: Int?
            init?(intValue: Int) {
                return nil
            }
        }
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var tempObject: WikiData? = nil
            for key in container.allKeys {
                let decodedObject = try container.decode(WikiData.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                tempObject = decodedObject
            }
            resultData = tempObject!
        }
    
}

struct WikiData: Codable {
    let pageid, ns: Int
    let title: String
    let thumbnail: WikiImage?
    let contentmodel, pagelanguage, pagelanguagehtmlcode: String
    let pagelanguagedir: String
    let lastrevid, length: Int
    let extract: String
}

// MARK: - Thumbnail
struct WikiImage: Codable {
    let source: String
    let width, height: Int
    
    func formattedImageLink(width: Int)-> String{
        if source.contains("38px"){
            let urlstring = source
            let formatedURL = urlstring.replacingOccurrences(of: "38px", with: "\(width)px")
            return formatedURL
        } else if source.contains("50px"){
            let urlstring = source
            let formatedURL = urlstring.replacingOccurrences(of: "50px", with: "\(width)px")
            return formatedURL
        } else {
            return source
        }
    }
}


extension WikiAPIResult {
    static let sampleUser: WikiAPIResult = {
        let response: WikiAPIResult? = try? Bundle.main.loadAndDecodeJSON(filename: "api-result")
        return response! // MARK: - Always make sure userSample is in the Bundle
    }()
}

@available(iOS 15, *)
extension String {
    var htmlAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else {return nil}
        do {
            return try NSAttributedString(data: data, options: [.documentType : NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            return nil
        }
    }
}
