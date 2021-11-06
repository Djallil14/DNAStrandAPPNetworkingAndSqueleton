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
            ZStack{
                if let image = wikidata.thumbnail {
                    AsyncImage(url: URL(string: image.formattedImageLink(width: 300))) { image in
                        image
                            .resizable()
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Color.secondary
                }
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                    Text(wikidata.title)
                        .font(.headline)
                        .padding()
                        Spacer()
                    }.background(.ultraThinMaterial)
                }
            }.aspectRatio(1, contentMode: .fit)
                .cornerRadius(18)
        }
        .shadow(color: .accentColor.opacity(0.2), radius: 3, x: 1, y: 2)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GeneView(gene: WikiAPIResult.sampleUser)
    }
}
