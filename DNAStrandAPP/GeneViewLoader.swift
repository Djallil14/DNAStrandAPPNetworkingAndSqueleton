//
//  GeneViewLoader.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-05.
//

import SwiftUI

struct GeneViewLoader: View {
    @ObservedObject var geneVM: GeneViewModel
    let showGene: Gene
    var body: some View {
        ZStack{
                switch geneVM.dataPhase{
                case .empty:
                    ProgressView()
                case .success(let gene):
                    GeneView(gene: gene)
                case .failure(let error):
                    Text("Error: \(error.localizedDescription)")
                }
        }
        .onAppear{
            print(showGene)
            getGene()
        }
        .task {
            getGene()
        }
       
    }
    private func getGene(){
        Task{
            await geneVM.getGene(gene: showGene)
        }
    }
}
//struct GeneViewLoader_Previews: PreviewProvider {
//    static var previews: some View {
//        GeneViewLoader(geneVM: GeneViewModel(), showGene: .Insulin)
//    }
//}
