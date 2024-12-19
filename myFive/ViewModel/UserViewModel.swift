//
//  UserViewModel.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 19/12/24.
//

import Combine
import Foundation

// MARK: - UserViewModel
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let fetchUsersUseCase: FetchUsersUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(fetchUsersUseCase: FetchUsersUseCaseProtocol) {
        self.fetchUsersUseCase = fetchUsersUseCase
        setupSearchListener()
    }
    
    func fetchUsers() {
        isLoading = true
        errorMessage = nil
        
        fetchUsersUseCase.execute()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] users in
                guard let self = self else { return }
                self.users = users
                self.filteredUsers = self.users
            })
            .store(in: &cancellables)
    }
    
    private func setupSearchListener() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                guard let self = self else { return }
                if searchText.isEmpty {
                    self.filteredUsers = self.users
                } else {
                    self.filteredUsers = self.users.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
                }
            }
            .store(in: &cancellables)
    }
}
