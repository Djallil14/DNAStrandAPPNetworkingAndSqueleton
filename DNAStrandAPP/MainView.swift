//
//  MainView.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-05.
//

import SwiftUI

struct MainView: View {
    @StateObject var geneStore = GeneViewModel()
    var body: some View {
            NavigationView{
                GeneViewLoader(geneVM: geneStore, showGene: .Insulin)
                    .navigationTitle("Most Popular Genes")
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
