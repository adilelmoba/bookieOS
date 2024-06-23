//
//  ArticleInteractor.swift
//  ELMOBACHIAdil
//
//  Created by Adil on 22/06/2023.
//

import Foundation

struct ArticleInteractor {
    private var articleRepository = ArticleRepository()
    
    func addArticle(title: String, image: String, content: String, creator: UserDTO, comments: [CommentDTO]) async {
        let id = UUID().uuidString
        let article = ArticleDTO(id: id, title: title, image: image, content: content, creator: creator, comments: comments)
        await articleRepository.create(article)
    }

    func fetchArticle(id: String) async -> ArticleDTO? {
        return await articleRepository.getArticle(from: id)
    }
    
    func updateArticle(id: String, title: String, image: String, content: String, creator: UserDTO, comments: [CommentDTO]) async {
        let article = ArticleDTO(id: id, title: title, image: image, content: content, creator: creator, comments: comments)
        await articleRepository.update(article)
    }

    func deleteArticle(id: String) async {
        await articleRepository.delete(from: id)
    }

    func fetchArticles(completion: @escaping ([ArticleDTO]) -> Void) {
        articleRepository.getAllArticles { articles in
            completion(articles)
        }
    }
}

