//
//  CoinAPI.swift
//  
//
//  Created by 11 on 12.10.2026.
//

import Foundation

enum CoinGeckoAPI{
    private static let baseURL = "https://api.coingecko.com/api/v3/coins/markets"
    
    static func coinsURL(limit: Int = 100) -> URL? {
        let path = "\(baseURL)/coins/markets"
        let query = "vs_currency=usd&order=market_cap_desc&per_page=\(limit)&page=1&sparkline=false&price_change_percentage=24h"
        
        return URL(string: "\(path)?\(query)")
    }
}
