//
//  ELMOBACHIAdilApp.swift
//  ELMOBACHIAdil
//
//  Created by Adil on 22/06/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct ELMOBACHIAdilApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("Configured Firebase!  ✅")

    return true
  }
}
