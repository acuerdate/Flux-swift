//
//  Coin.swift
//  
//
//  Created by 11 on 12.10.2026.
//

import Foundation

sruct Coin: Identifiable, Codable{
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
