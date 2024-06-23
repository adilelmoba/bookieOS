//
//  LoginView.swift
//  BaseProject
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    
    @State private var mode: Mode = .login
    
    private var buttonText: String {
        switch mode {
        case .login:
            return "Login"
        case .signup:
            return "Sign Up"
        }
    }
    
    private var switchModeText: String {
        switch mode {
        case .login:
            return "Don't have an account? Sign up"
        case .signup:
            return "Already have an account? Log in"
        }
    }
    
    var body: some View {
        VStack(spacing: 12) {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            if(mode == .login) {
                Button {
                    login()
                } label: {
                    Text(buttonText)
                        .foregroundColor(.white)
                        .bold()
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                }
                
            } else {
                Button {
                    signUp()
                } label: {
                    Text(buttonText)
                        .foregroundColor(.white)
                        .bold()
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                }
            }
            
            Button {
                mode = (mode == .login) ? .signup : .login
            } label: {
                Text(switchModeText)
                    .foregroundColor(.blue)
                    .bold()
            }
    
        }
        .textFieldStyle(.roundedBorder)
        .padding()
        
    }
    
    private enum Mode {
        case login
        case signup
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error logging in: \(error)")
            } else {
                print("Logged in successfully")
                isLoggedIn = true

            }
        }
    }
    
    private func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error signing up: \(error)")
            } else {
                print("Signed up successfully")
                isLoggedIn = true
                // Transition to the next screen here
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
