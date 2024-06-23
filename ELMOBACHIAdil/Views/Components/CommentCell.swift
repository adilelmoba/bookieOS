//
//  CommentCell.swift
//  BaseProject
//

import SwiftUI

struct CommentCell: View {
    let comment: CommentDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(comment.creator.name)
                .bold()
            Text(comment.commentText)
        }
        .font(.footnote)
        .foregroundColor(Color(white: 0.4))
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(comment: CommentDTO(id: "1", creator: UserDTO(id: "1", name: "John Doe", email: "johndoe@example.com"), commentText: "Lorem ipsum sont les premiers mots généralement utilisés dans les maquettes en imprimerie afin de calibrer les textes."))
            .padding()
    }
}

