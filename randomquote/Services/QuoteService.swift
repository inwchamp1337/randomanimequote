//
//  QuoteService.swift
//  randomquote
//
//  Created by Csy on 18/2/2568 BE.
//


import Foundation

class QuoteService {
    static let shared = QuoteService()
    
    private init() {}
    
    func fetchRandomQuote(completion: @escaping (Result<QuoteResponse, Error>) -> Void) {
        guard let url = URL(string: "https://animechan.io/api/v1/quotes/random") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let quoteResponse = try JSONDecoder().decode(QuoteResponse.self, from: data)
                completion(.success(quoteResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
