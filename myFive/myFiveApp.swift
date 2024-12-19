//
//  myFiveApp.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 19/12/24.
//

import SwiftUI

let baseURL: URL = {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
        fatalError("Invalid URL string")
    }
    return url
}()
let apiClient = APIClient(baseURL: baseURL)
let fetchUsersUseCase = FetchUsersUseCase(apiClient: apiClient)
let userViewModel = UserViewModel(fetchUsersUseCase: fetchUsersUseCase)

@main
struct myFiveApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView(viewModel: userViewModel)
        }
    }
}
