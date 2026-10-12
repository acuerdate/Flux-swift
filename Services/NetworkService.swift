// xcode: set sdk=iOS

//
//  NetworkService.swift
//  
//
//  Created by 11 on 12.10.2026.
//

import Foundation

enum NetworkError: LocalizedError{
    case invalidURL
    case noData
    case decodingFailed(Error)
    case serverError(statusCode: Int)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Неверный адрес запроса"
        case .noData:
            return "Сервер вернул пустой ответ"
        case .decodingFailed:
            return "Не удалось обработать данные"
        case .serverError(let code):
            return "Ошибка сервера. Код: \(code)."
        case .unknown:
            return "Что-то пошло не так. Попробуйте позже"
        }
    }
}

final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func fetch<T: Decodable>(_ url: URL) async throws -> T {
        let(data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else{
            throw NetworkError.noData
        }
        
        guard(200...299).contains(httpResponse.statusCode) else{
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        }catch{
            throw NetworkError.decodingFailed(error)
        }
    }
}
