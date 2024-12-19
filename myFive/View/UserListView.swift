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
                
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.filteredUsers) { user in
                        UserCell(user: user)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .cornerRadius(10)
                    }
                    .listRowSeparator(.hidden)
                    
                }
            }
            .navigationTitle("Users")
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}
