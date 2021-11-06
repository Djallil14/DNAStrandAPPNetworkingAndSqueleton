//
//  GeneDetailView.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-06.
//

import SwiftUI

struct GeneDetailView: View {
    @Environment(\.dismiss) var dismiss
    let gene: WikiAPIResult
    var geneData: WikiData {
        gene.query.pages.resultData
    }
    var body: some View {
        ZStack(alignment:.top){
            ScrollView{
                VStack(alignment:.leading, spacing: 0){
                    if let image = geneData.thumbnail {
                        AsyncImage(url: URL(string: image.formattedImageLink(width: 500))) { image in
                            image
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .overlay(
                            VStack{
                                Button(action: {dismiss()}){
                                Image(systemName: "xmark")
                                }.tint(.black)
                                .padding(8)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .padding(24)
                                .position(x: 40, y: 60)
                                Spacer()
                                HStack{
                                    Spacer()
                                Text(geneData.title)
                                        .bold()
                                        .font(.title2)
                                        .padding()
                                    Spacer()
                                }.background(.ultraThinMaterial)
                            }
                        )
                        .cornerRadius(12)
                    }
                    Text("Description").font(.headline)
                        .padding()
                    Text(AttributedString(geneData.extract.htmlAttributedString!))
                        .padding()
                    Spacer()
                }
            }
        }.edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
    }
}

struct GeneDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OtherGeneDetailView(gene: WikiAPIResult.sampleUser)
    }
}

struct OtherGeneDetailView: View {
    @Environment(\.dismiss) var dismiss
    let gene: WikiAPIResult
    var geneData: WikiData {
        gene.query.pages.resultData
    }
    @State var geneURL: WikiData? = nil
    var body: some View {
        ZStack(alignment:.top){
            ScrollView{
                VStack(alignment:.leading, spacing: 0){
                    if let image = geneData.thumbnail {
                        AsyncImage(url: URL(string: image.formattedImageLink(width: 500))) { image in
                            image
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .overlay(
                            VStack{
                                    Button(action: {dismiss()}){
                                    Image(systemName: "xmark")
                                    }.tint(.black)
                                    .padding(8)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                                    .padding(24)
                                    .position(x: 40, y: 60)
                                Spacer()
                                HStack{
                                    Spacer()
                                Text(geneData.title)
                                        .bold()
                                        .font(.title2)
                                        .padding()
                                    Spacer()
                                }.background(.ultraThinMaterial)
                            }
                        )
                        .cornerRadius(12)
                    }
                    Text("Description").font(.headline)
                        .padding()
                    Text(geneData.firstParagraph ?? "")
                        .padding()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation{
                            geneURL = geneData
                            }
                        }){
                            Label("Show me more", systemImage: "safari")
                                .padding(8)
                        }.buttonStyle(.borderedProminent)
                        Spacer()
                    }.sheet(item: $geneURL){gene in
                        GeneWikipediaWebView(url: gene.wikipediaLink)
                    }
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
    }
}
