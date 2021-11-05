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
        ScrollView(){
            VStack{
                ForEach(Gene.allCases, id:\.self){gene in
                    GeneViewLoader(geneVM: geneStore, showGene: gene)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
