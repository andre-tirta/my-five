//
//  UserModel.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 19/12/24.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: Int?
    let name, username, email, phone, website: String?
    let address: Address?
    let company: Company?

    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

