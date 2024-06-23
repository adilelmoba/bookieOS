//
//  CommentInteractor.swift
//  ELMOBACHIAdil
//
//  Created by Adil on 22/06/2023.
//

import Foundation

struct CommentInteractor {
    private var commentRepository = CommentRepository()
    
    func addComment(creator: UserDTO, comment: String, for articleId: String) async {
        let id = UUID().uuidString
        let commentDTO = CommentDTO(id: id, creator: creator, commentText: comment)
        await commentRepository.create(commentDTO, for: articleId)
    }
    
    func fetchComment(id: String, for articleId: String) async -> CommentDTO? {
        return await commentRepository.getComment(from: id, for: articleId)
    }
    
    func updateComment(id: String, creator: UserDTO, comment: String, for articleId: String) async {
        let commentDTO = CommentDTO(id: id, creator: creator, commentText: comment)
        await commentRepository.update(commentDTO, for: articleId)
    }

    func deleteComment(id: String, for articleId: String) async {
        await commentRepository.delete(from: id, for: articleId)
    }
    
    func fetchAllComments(for articleId: String) async -> [CommentDTO] {
        return await commentRepository.getAllComments(for: articleId)
    }
}

