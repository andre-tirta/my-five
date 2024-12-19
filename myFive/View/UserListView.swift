//
//  UserListView.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 19/12/24.
//

import Foundation
import SwiftUI

// MARK: - UserListView
struct UserListView: View {
    @StateObject private var viewModel: UserViewModel
    
    init(viewModel: UserViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $viewModel.searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.leading)
                        .frame(height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .cornerRadius(10)
                        .shadow(color: Color(hex: "#F7D6B4"), radius: 5, x: 2, y: 3)
                        .overlay(
                            Group {
                                if !viewModel.searchText.isEmpty {
                                    Button(action: {
                                        viewModel.searchText = ""
                                    }) {
                                        Image("clearInput")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .padding(.trailing, 8)
                                    }
                                }
                            },
                            alignment: .trailing
                        )
                        .background(Color.white)
                    
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Image("magnifyingGlass")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.leading, 15)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 17)
                
                Text(viewModel.searchText.isEmpty ? "ALL USERS" : "SEARCH RESULTS")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top)
                    .padding(.bottom)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .overlay(
                        VStack {
                            Rectangle()
                                .frame(height: 1) // Top border
                                .foregroundColor(Color.black)
                            Spacer()
                            Rectangle()
                                .frame(height: 1) // Bottom border
                                .foregroundColor(Color.black)
                        }
                    )
                
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.filteredUsers) { user in
                        UserCell(user: user, searchText: $viewModel.searchText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 70)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .cornerRadius(10)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "#F9F5F2"))
            .navigationTitle("Users")
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

#Preview {
    let baseURL: URL = {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            fatalError("Invalid URL string")
        }
        return url
    }()
    let apiClient = APIClient(baseURL: baseURL)
    let fetchUsersUseCase = FetchUsersUseCase(apiClient: apiClient)
    let userViewModel = UserViewModel(fetchUsersUseCase: fetchUsersUseCase)
    return UserListView(viewModel: userViewModel)
}

