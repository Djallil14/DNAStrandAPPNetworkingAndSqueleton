//
//  GeneViewModel.swift
//  DNAStrandAPP
//
//  Created by Djallil Elkebir on 2021-11-05.
//


import SwiftUI

@MainActor //Running on the main queue
class GeneViewModel: ObservableObject {
    @Published var dataPhase = DataFetchPhase<[WikiAPIResult]>.empty
    @Published var isLoading: Bool = false
    private let networkManger = NetworkManager.shared
    
    init(genes: [WikiAPIResult] = []){
        if !genes.isEmpty {
            self.dataPhase = .success(genes)
        } else {
            self.dataPhase = .empty
        }
    }
    
    func getGene() async {
        // starting loading Animation
        withAnimation{
            isLoading = true
        }
        dataPhase = .empty
        do {
            var tempArray: [WikiAPIResult] = []
            // getting all the genes from our Gene Enum
            for genes in Gene.allCases {
                let gene = try await networkManger.getGene(gene: genes)
                if let gene = gene {
                    tempArray.append(gene)
                }
            }
            // if we get the data we returned a succeded fetch and we stop the loading animation
            withAnimation(.spring()){
                dataPhase = .success(tempArray)
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
