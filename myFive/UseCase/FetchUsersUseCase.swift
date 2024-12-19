//
//  FetchUsersUseCase.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 19/12/24.
//

import Combine
import Foundation

// MARK: - Protocol for FetchUsersUseCase
protocol FetchUsersUseCaseProtocol {
    func execute() -> AnyPublisher<[User], Error>
}

// MARK: - FetchUsersUseCase Implementation
class FetchUsersUseCase: FetchUsersUseCaseProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func execute() -> AnyPublisher<[User], Error> {
        return apiClient.fetch(endpoint: "/users")
    }
}
