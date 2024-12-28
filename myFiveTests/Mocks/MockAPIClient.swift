//
//  MockAPIClient.swift
//  myFiveTests
//
//  Created by Andre Tirta Wijaya on 28/12/24.
//

import Combine
@testable import myFive

class MockAPIClient: APIClientProtocol {
    var mockResult: AnyPublisher<[User], Error>?

    func fetch<T>(endpoint: String) -> AnyPublisher<T, Error> where T : Decodable {
        guard let result = mockResult as? AnyPublisher<T, Error> else {
            fatalError("MockAPIClient: Expected result type doesn't match.")
        }
        return result
    }
}

