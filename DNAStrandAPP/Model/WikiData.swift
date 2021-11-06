//
//  WikiData.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-05.
//

import Foundation
import SwiftSoup

struct WikiData: Codable {
    let pageid, ns: Int
    let title: String
    let thumbnail: WikiImage?
    let contentmodel, pagelanguage, pagelanguagehtmlcode: String
    let pagelanguagedir: String
    let lastrevid, length: Int
    let extract: String
}

// Formatting
extension WikiData {
    // all the titles separted in the array
    var allTheTitles: [String]? {
        let html = extract
        let utfHTML = String(html.utf8)
        do {
            let doc: Document = try SwiftSoup.parse(utfHTML)
            let titles = try doc.body()?.select("h2")
            var tempArray: [String] = []
            let _ = try titles?.forEach({ Element in
                let paragraphe = try Element.text()
                tempArray.append(paragraphe)
            })
            return tempArray
            
        } catch Exception.Error(let type, let message) {
            print("Message: \(message), Type: \(type)")
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    // all the paragraphs
    var allTheParagraphs: [String]? {
        let html = extract
        let utfHTML = String(html.utf8)
        do {
            let doc: Document = try SwiftSoup.parse(utfHTML)
            let titles = try doc.body()?.select("p")
            var tempArray: [String] = []
            let _ = try titles?.forEach({ Element in
                let paragraphe = try Element.text()
                tempArray.append(paragraphe)
            })
            return tempArray
            
        } catch Exception.Error(let type, let message) {
            print("Message: \(message), Type: \(type)")
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
