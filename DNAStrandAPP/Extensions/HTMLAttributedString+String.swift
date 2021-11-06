//
//  HTMLAttributedString+String.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-05.
//

import Foundation

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
