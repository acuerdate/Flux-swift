//
//  CoinRowView.swift
//  FluxProject
//
//  Created by 11 on 13.10.2026.
//

import SwiftUI

struct CoinRow: View {
    let coin: Coin
    
    var body: some View {
        HStack(spacing: 12){
            AsyncImage(url: URL(string: coin.image)){ image in
                image
                    .resizable()
                    .scaledToFit()
            }placeholder: {
                Circle().fill(Color.gray.opacity(0.2))
            }
            .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 2){
                Text(coin.name)
                    .font(.headline)
                Text(coin.currentPrice, format: .currency(code: "USD"))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("\(coin.priceChangePercentage24h / 100, format: .percent.precision(.fractionLength(2)).sign(strategy: .always(includingZero: false)))")
                .font(.subheadline)
                .foregroundStyle(coin.priceChangePercentage24h >= 0 ? .green : .red)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CoinRow(coin: .bitcoinMock)
        .padding()
}
