//
//  User.swift
//  ELMOBACHIAdil
//
//  Created by Adil on 22/06/2023.
//

import Foundation

struct UserDTO: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
}
