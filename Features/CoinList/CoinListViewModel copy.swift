//
//  CoinListViewModel.swift
//  
//
//  Created by 11 on 12.10.2026.
//

import Foundation

@MainActor
final class CoinListViewModel: ObservableObject{
    
    enum State{
        case loading
        case loaded([Coin])
        case failed(String)
    }
    
    @Published private(set) var state: State = .loading
    @Published var searchText: String = ""
    
    private let network: NetworkService
    
    init(network: NetworkService = .shared){
        self.network = network
    }
    
    func loadCoins() async {
        guard let url = CoinGeckoAPI.coinsURL() else{
            state = .failed("Не удалось построить адрес запроса.")
            return
        }
        
        state = .loading
        
        do{
            let coins: [Coin] = try await network.fetch(url)
            state = .loaded(coins)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}

