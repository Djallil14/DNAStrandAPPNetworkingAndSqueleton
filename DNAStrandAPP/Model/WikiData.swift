//
//  WikiData.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-05.
//

import Foundation
import SwiftSoup

struct WikiData: Codable, Identifiable {
    let pageid, ns: Int
    let title: String
    let thumbnail: WikiImage?
    let contentmodel, pagelanguage, pagelanguagehtmlcode: String
    let pagelanguagedir: String
    let lastrevid, length: Int
    let extract: String
    
    // comforming to Identifiable
    var id: String {
        title
    }
}

// Formatting
extension WikiData {
    var wikipediaLink: URL {
        let url = URL(string: "https://en.wikipedia.org/wiki/\(title)")
        guard let unwrappedURL = url else {
            return URL(string:"https://en.wikipedia.org/wiki/")!
        }
        return unwrappedURL
    }
    var firstParagraph: String? {
        let html = extract
        let utfHTML = String(html.utf8)
        do {
            // parsing our document with SwiftSoup
            let doc: Document = try SwiftSoup.parse(utfHTML)
            // getting all the h2 tags
            let paragraphs = try doc.body()?.select("p")
            let firstParagraphe = try paragraphs?.first()?.text()
            return firstParagraphe
            
        } catch Exception.Error(let type, let message) {
            print("Message: \(message), Type: \(type)")
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    // all the titles separted in the array
    var allTheTitles: [String]? {
        let html = extract
        let utfHTML = String(html.utf8)
        do {
            // parsing our document with SwiftSoup
            let doc: Document = try SwiftSoup.parse(utfHTML)
            // getting all the h2 tags
            let titles = try doc.body()?.select("h2")
            var tempArray: [String] = []
            let _ = try titles?.forEach({ Element in
                let paragraphe = try Element.text()
                // appending all the h2 titles to our temporary array
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
    
    // all the paragraphs sparated in an array
    var allTheParagraphs: [String]? {
        let html = extract
        let utfHTML = String(html.utf8)
        do {
            // parsing our document with SwiftSoup
            let doc: Document = try SwiftSoup.parse(utfHTML)
            // getting all the p tags
            let ptags = try doc.body()?.select("p")
            var tempArray: [String] = []
            let _ = try ptags?.forEach({ Element in
                let paragraphe = try Element.text()
                // appending all the paragraphs to our temporary array
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
    
    var titleAndParagraphs: [String: String]? {
        do {
            var tempDic: [String:String] = [:]
            let html = extract
            let utfHTML = String(html.utf8)
            // parsing our document with SwiftSoup
            let doc: Document = try SwiftSoup.parse(utfHTML)
            // getting all the h2 tags
            let resultTitles: Elements? = try doc.select("span")
            // getting all the p tags after a title
            let resultParagraph: Elements? = try doc.select("span > p")
            print(resultTitles?.first())
            print(resultParagraph)
//            if let resultTitles = resultTitles {
//                for index in 0..<resultTitles.count {
//                    // appending title and the following paragraphe
//                    tempDic[try resultTitles[index].text()] = try resultParagraph?[index].text()
//                }
//            }
            print(tempDic)
            return tempDic
        } catch Exception.Error(let type, let message) {
            print("Message: \(message), type: \(type)")
        } catch {
            print("error")
        }
        return nil
    }
    var otherTitleAndParagraphs: [String: String]? {
        do {
            var tempDic: [String:String] = [:]
            let html = extract
            let utfHTML = String(html.utf8)
            // parsing our document with SwiftSoup
            let doc: Document = try SwiftSoup.parse(utfHTML)
            // getting all the h2 tags
            let resultTitles: Elements? = try doc.select("span")
            // getting all the p tags after a title
            let resultParagraph: Elements? = try doc.select("p ~ span")
            if let resultTitles = resultTitles {
                for index in 0..<resultTitles.count {
                    // appending title and the following paragraphe
                    tempDic[try resultTitles[index].text()] = try resultParagraph?[index].text()
                }
            }
//            print("Other: \(tempDic)")
            return tempDic
        } catch Exception.Error(let type, let message) {
            print("Message: \(message), type: \(type)")
        } catch {
            print("error")
        }
        return nil
    }
}

//let pngs: Elements = try doc.select("img[src$=.png]") to get png images in the article
// i got to look for parsing the span tag that is wrapping the titles
