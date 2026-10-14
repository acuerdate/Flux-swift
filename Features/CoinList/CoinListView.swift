//
//  CoinListView.swift
//  
//
//  Created by 11 on 12.10.2026.
//

import SwiftUI

struct CoinListView: View {
    
    @StateObject private var viewModel = CoinListViewModel()
    
    var body: some View {
        NavigationStack{
            content
                .navigationTitle("Flux")
        }
        .task{
            await viewModel.loadCoins()
        }
    }
    
    @ViewBuilder
    private var content: some View{
        switch viewModel.state{
        case .loading:
            ProgressView("Загрузка")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .loaded(let coins):
            List(filtered(coins)){ coin in
                CoinRow(coin: coin)
            }
            
        case .failed(let message):
            errorView(message: message)
        }
    }
    
    private func filtered(_ coins: [Coin]) -> [Coin]{
        if viewModel.searchText.isEmpty { return coins }
        return coins.filter{
            $0.name.localizedCaseInsensitiveContains(viewModel.searchText)
        }
    }
    
    private func errorView(message: String) -> some View {
        VStack(spacing: 12){
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            
            Button("Повторить"){
                Task{ await viewModel.loadCoins() }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CoinListView()
}
