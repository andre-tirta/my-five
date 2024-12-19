//
//  AddressModel.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 19/12/24.
//

import Foundation

struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
}
