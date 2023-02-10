//
//  UserResponse.swift
//  MVVM Final
//
//  Created by Ekambaram E on 12/14/22.
//

import Foundation

struct UserResponseModel: Codable {
    
    let data: [Users]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Users: Codable {

    let email: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
    }
}


