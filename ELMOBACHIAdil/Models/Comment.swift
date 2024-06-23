//
//  Comment.swift
//  ELMOBACHIAdil
//
//  Created by Adil on 22/06/2023.
//

import Foundation

struct CommentDTO: Codable, Identifiable {
    let id: String
    let creator: UserDTO
    let commentText: String
}
