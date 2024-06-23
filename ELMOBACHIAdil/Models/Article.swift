//
//  Article.swift
//  ELMOBACHIAdil
//
//  Created by Adil on 22/06/2023.
//

import Foundation

struct ArticleDTO: Codable, Identifiable {
    let id: String
    let title: String
    let image: String
    let content: String
    var creator: UserDTO?
    var comments: [CommentDTO]?
}
