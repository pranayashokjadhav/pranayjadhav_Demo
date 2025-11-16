//
//  PMNetworkManager.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 15/11/25.
//
import Foundation

class PMNetworkManager {
    
    private init() {}
    
    static let shared = PMNetworkManager()
    
    func fetchHoldings(completion: @escaping (Result<[PMUserHolding], Error>) -> Void) {
        guard let url = URL(string: EnvironmentVariables.baseURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data available", code: 0)))
                return
            }

            do {
                let data = try JSONDecoder().decode(PMHoldingsResponse.self, from: data)
                completion(.success(data.data?.userHolding ?? []))
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
}
