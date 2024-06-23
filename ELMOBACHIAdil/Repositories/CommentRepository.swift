//
//  CommentRepository.swift
//  ELMOBACHIAdil
//
//  Created by Adil on 22/06/2023.
//

import Foundation
import FirebaseDatabase

struct CommentRepository {
    let reference: DatabaseReference! = Database.database(url: "https://evaluationfinale-53764-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    func create(_ restComment: CommentDTO, for articleId: String) async {
        do {
            let data = try JSONEncoder().encode(restComment)
            let dictionary = try JSONSerialization.jsonObject(with: data)
            
            try await reference
                .child("articles")
                .child(articleId)
                .child("comments")
                .child(restComment.id)
                .setValue(dictionary)
        } catch {
            print("🚨 \(error)")
        }
    }
    
    func getComment(from id: String, for articleId: String) async -> CommentDTO? {
        do {
            let snapshot = try await reference.child("articles/\(articleId)/comments/\(id)").getData()
            
            if let value = snapshot.value {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let restComment = try JSONDecoder().decode(CommentDTO.self, from: jsonData)
                return restComment
            } else {
                return nil
            }
        } catch {
            print("🚨 \(error)")
            return nil
        }
    }
    
    func update(_ restComment: CommentDTO, for articleId: String) async {
        do {
            let data = try JSONEncoder().encode(restComment)
            let dictionary = try JSONSerialization.jsonObject(with: data)
            
            try await reference
                .child("articles")
                .child(articleId)
                .child("comments")
                .child(restComment.id)
                .updateChildValues(dictionary as! [AnyHashable : Any])
        } catch {
            print("🚨 \(error)")
        }
    }
    
    func delete(from id: String, for articleId: String) async {
        do {
            try await reference.child("articles/\(articleId)/comments/\(id)").removeValue()
        } catch {
            print("🚨 \(error)")
        }
    }
    
    func getAllComments(for articleId: String) async -> [CommentDTO] {
        do {
            let snapshot = try await reference.child("articles/\(articleId)/comments").getData()
            
            if let value = snapshot.value as? NSDictionary {
                let jsonData = try JSONSerialization.data(withJSONObject: value.allValues)
                let restComments = try JSONDecoder().decode([CommentDTO].self, from: jsonData)
                return restComments
            } else {
                return []
            }
        } catch {
            print("🚨 \(error)")
            return []
        }
    }
}
