//
//  NewCommentField.swift
//  BaseProject
//

import SwiftUI

struct NewCommentField: View {
    
    @Binding var comment: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ajouter un commentaire")
                .font(.footnote)
                .bold()
            TextEditor(text: $comment)
                .padding(8)
                .font(.footnote)
                .frame(height: 200)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 0.5))
                        .foregroundColor(.gray)
                }
                
        }
    }
}

struct NewCommentField_Previews: PreviewProvider {
    static var previews: some View {
        NewCommentField(comment: .constant(""))
            .padding()
    }
}
