//
//  ContentView.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-05.
//

import SwiftUI

struct GeneView: View {
    let gene: WikiAPIResult
    var wikidata: WikiData {
        gene.query.pages.resultData
    }
    @State var formatedURL: String = ""
    var body: some View {
        VStack{
            Text(wikidata.title)
            ZStack{
                if let image = wikidata.thumbnail {
                    AsyncImage(url: URL(string: image.formattedImageLink(width: 800))) { image in
                        image
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            ScrollView(.vertical){
            Text(AttributedString(wikidata.extract.htmlAttributedString!))
                    .padding()
            }
        }.onAppear{
            // for testing purposes
            print(wikidata.titleAndParagraphs)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GeneView(gene: WikiAPIResult.sampleUser)
    }
}
