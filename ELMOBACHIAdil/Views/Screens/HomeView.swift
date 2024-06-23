//
//  HomeView.swift
//  BaseProject
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var articles: [ArticleDTO] = []
    @State private var isLoading: Bool = true
    
    private let repository = ArticleRepository()
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                } else {
                    List(articles, id: \.id) { article in
                        NavigationLink(destination: BlogContent(article: article)) {
                            BlogCell(article: article)
                        }
                    }
                }
                
                if((Auth.auth().currentUser) != nil) {
                    Button {
                        signOut()
                    } label: {
                        Text("Sign Out")
                            .foregroundColor(.red)
                            .bold()
                    }
                }
                
            }
            .padding()
            .onAppear {
                isLoading = true
                repository.getAllArticles { fetchedArticles in
                    DispatchQueue.main.async {
                        articles = fetchedArticles
                        isLoading = false
                    }
                }
            }
            .navigationTitle("Articles")
        }
    }

    private func signOut() {
        do {
            try Auth.auth().signOut()
            // Transition to the login screen or another appropriate screen here
        } catch {
            print("Error signing out: \(error)")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


