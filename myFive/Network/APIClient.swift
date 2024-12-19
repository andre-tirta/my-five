//
//  APIClient.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 19/12/24.
//

import Combine
import Foundation

// MARK: - Protocol for APIClient
protocol APIClientProtocol {
    func fetch<T: Decodable>(endpoint: String) -> AnyPublisher<T, Error>
}

// MARK: - APIClient Implementation (Simple URLSession-based implementation)
class APIClient: APIClientProtocol {
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func fetch<T: Decodable>(endpoint: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
