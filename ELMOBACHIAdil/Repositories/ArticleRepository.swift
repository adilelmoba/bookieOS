//
//  ArticleRepository.swift
//  ELMOBACHIAdil
//
//  Created by Adil on 22/06/2023.
//

import Foundation
import FirebaseDatabase

struct ArticleRepository {
    let reference: DatabaseReference! = Database.database(url: "https://evaluationfinale-53764-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    func create(_ restArticle: ArticleDTO) async {
        do {
            let data = try JSONEncoder().encode(restArticle)
            let dictionary = try JSONSerialization.jsonObject(with: data)
            
            try await reference
                .child("articles")
                .child(restArticle.id)
                .setValue(dictionary)
        } catch {
            print("🚨 \(error)")
        }
    }
    
    func getArticle(from id: String) async -> ArticleDTO? {
        do {
            let snapshot = try await reference.child("articles/\(id)").getData()
            
            if let value = snapshot.value {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let restArticle = try JSONDecoder().decode(ArticleDTO.self, from: jsonData)
                return restArticle
            } else {
                return nil
            }
        } catch {
            print("🚨 \(error)")
            return nil
        }
    }
    
    func update(_ restArticle: ArticleDTO) async {
        do {
            let data = try JSONEncoder().encode(restArticle)
            let dictionary = try JSONSerialization.jsonObject(with: data)
            
            try await reference
                .child("articles")
                .child(restArticle.id)
                .updateChildValues(dictionary as! [AnyHashable : Any])
        } catch {
            print("🚨 \(error)")
        }
    }
    
    func delete(from id: String) async {
        do {
            try await reference.child("articles/\(id)").removeValue()
        } catch {
            print("🚨 \(error)")
        }
    }
    
    
    func getAllArticles(completion: @escaping ([ArticleDTO]) -> Void) {
        reference.child("articles").observeSingleEvent(of: .value) { snapshot in
            var articles: [ArticleDTO] = []

            guard let snapshotValue = snapshot.value as? [String: Any] else {
                completion([])
                return
            }

            if let articleDict = snapshotValue as? [String: Any] {
                guard let creatorDict = articleDict["creator"] as? [String: Any],
                      let creatorID = creatorDict["id"] as? String,
                      let creatorName = creatorDict["name"] as? String,
                      let creatorEmail = creatorDict["email"] as? String,
                      let id = articleDict["id"] as? String,
                      let title = articleDict["title"] as? String,
                      let image = articleDict["image"] as? String,
                      let content = articleDict["content"] as? String
                else {
                    print("Error parsing article: \(articleDict)")
                    completion([])
                    return
                }

                var comments: [CommentDTO] = []
                if let commentsArray = articleDict["comments"] as? [[String: Any]] {
                    for commentDict in commentsArray {
                        guard let commentCreatorDict = commentDict["creator"] as? [String: Any],
                              let commentCreatorID = commentCreatorDict["id"] as? String,
                              let commentCreatorName = commentCreatorDict["name"] as? String,
                              let commentCreatorEmail = commentCreatorDict["email"] as? String,
                              let commentID = commentDict["id"] as? String,
                              let commentText = commentDict["commentText"] as? String
                        else {
                            print("Error parsing comment: \(commentDict)")
                            continue
                        }

                        let commentCreator = UserDTO(id: commentCreatorID, name: commentCreatorName, email: commentCreatorEmail)
                        let comment = CommentDTO(id: commentID, creator: commentCreator, commentText: commentText)
                        comments.append(comment)
                    }
                } else {
                    print("No comments for article: \(articleDict)")
                }

                let creator = UserDTO(id: creatorID, name: creatorName, email: creatorEmail)
                let article = ArticleDTO(id: id, title: title, image: image, content: content, creator: creator, comments: comments)
                articles.append(article)
            } else {
                print("Invalid snapshot format: \(snapshotValue)")
            }

            print("Articles fetched: \(articles.count)")
            completion(articles)
        }
    }

}
