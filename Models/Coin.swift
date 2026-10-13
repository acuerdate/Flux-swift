//
//  Coin.swift
//  
//
//  Created by 11 on 12.10.2026.
//

import Foundation

struct Coin: Identifiable, Codable{
    let id: String
    let name: String
    let image: String
    let currentPrice: Double
    let priceChangePercentage24h: Double
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case image
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}

extension Coin{
    static let bitcoinMock = Coin(
        id: "bitcoin",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
        currentPrice: 67432.15,
        priceChangePercentage24h: 2.34
    )
    
    static let ethereumMock = Coin(
        id: "ethereum",
        name: "Ethereum",
        image: "https://assets.coingecko.com/coins/images/279/large/ethereum.png",
        currentPrice: 3456.78,
        priceChangePercentage24h: -1.21
    )
    
    static let solanaMock = Coin(
        id: "solana",
        name: "Solana",
        image: "https://assets.coingecko.com/coins/images/4128/large/solana.png",
        currentPrice: 178.45,
        priceChangePercentage24h: 5.67
        )
    
    static let mocks: [Coin] = [bitcoinMock, ethereumMock, solanaMock]
}
