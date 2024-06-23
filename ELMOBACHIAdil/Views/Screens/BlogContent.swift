//
//  BlogContent.swift
//  BaseProject
//

import SwiftUI

struct BlogContent: View {
    @State private var newComment: String = ""
    let article: ArticleDTO
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                image
                title
                content
                Divider()
                comments
            }
            .padding()
        }
    }
    
    private var image: some View {
        AsyncImage(url: URL(string: article.image)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Rectangle()
                .foregroundColor(.gray)
        }
        .frame(height: 200)
        .cornerRadius(10)
    }
    
    private var title: some View {
        Text(article.title)
            .font(.title)
            .bold()
    }
    
    private var content: some View {
        Text(article.content)
    }
    
    private var comments: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Commentaires")
                .font(.headline)
            ForEach(article.comments ?? []) { comment in
                CommentCell(comment: comment)
            }
            Group {
                commentField
            }
        }
    }
    
    private var commentField: some View {
        VStack(alignment: .trailing) {
            NewCommentField(comment: $newComment)
            Button {
                // TODO: Implement comment submission
            } label: {
                Text("Ajouter")
                    .bold()
            }
        }
    }
}

struct BlogContent_Previews: PreviewProvider {
    static var previews: some View {
        BlogContent(article: ArticleDTO(id: "1", title: "Sample Title", image: "https://example.com/image.jpg", content: "Sample content", creator: nil, comments: nil))
    }
}
