//
//  BlogCell.swift
//  BaseProject
//

import SwiftUI

struct BlogCell: View {
    let article: ArticleDTO
    
    var body: some View {
        HStack(spacing: 12) {
            image
            details
        }
        .padding()
        .foregroundColor(.primary)
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
        .frame(width: 100, height: 100)
        .clipped()
        .cornerRadius(10)
    }
    
    private var details: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(article.title)
                .font(.headline)
            Text(article.content)
                .lineLimit(3)
            Text("By \(article.creator?.name ?? "")")
                       .font(.subheadline)
                       .foregroundColor(.secondary)
        }
    }
}

struct BlogCell_Previews: PreviewProvider {
    static var previews: some View {
        BlogCell(article: ArticleDTO(id: "1", title: "Sample Title", image: "https://example.com/image.jpg", content: "This is a sample article content.", creator: nil, comments: nil))
    }
}

