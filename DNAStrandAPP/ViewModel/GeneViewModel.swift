//
//  GeneViewModel.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-05.
//


import SwiftUI

@MainActor //Running on the main queue
class GeneViewModel: ObservableObject {
    @Published var dataPhase = DataFetchPhase<WikiAPIResult>.empty
    @Published var isLoading: Bool = false
    private let networkManger = NetworkManager.shared
    
    init(genes: WikiAPIResult? = nil){
        if let genes = genes {
            self.dataPhase = .success(genes)
        } else {
            self.dataPhase = .empty
        }
    }
    
    func getGene(gene: Gene) async {
        print("refreshing")
        withAnimation{
            isLoading = true
        }
        dataPhase = .empty
        do {
            
            let gene = try await networkManger.getGene(gene: gene)
                withAnimation(.spring()){
                    dataPhase = .success(gene ?? WikiAPIResult.sampleUser)
                    isLoading = false
                }
        } catch {
            print(error)
            dataPhase = .failure(error)
            withAnimation{
                isLoading = false
            }
        }
    }
}
