//
//  PublisherExtenstion.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 28/12/24.
//

import Combine

extension Publisher {
    func asyncSink() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = self.sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    continuation.resume(throwing: error)
                }
                cancellable?.cancel()
            }, receiveValue: { value in
                continuation.resume(returning: value)
                cancellable?.cancel()
            })
        }
    }
}
