//
//  GeneWikipediaWebView.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-06.
//
import SafariServices
import SwiftUI

struct GeneWikipediaWebView: UIViewControllerRepresentable {
    
    let url: URL

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: self.url)
        return safariVC
    }
}
