//
//  Todo2App.swift
//  Todo2
//
//  Created by Pranav on 7/26/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
      let providerFactory = AppCheckDebugProviderFactory()
      AppCheck.setAppCheckProviderFactory(providerFactory)
      FirebaseApp.configure()
      Auth.auth().signInAnonymously()

    return true
  }
}

@main
struct Todo2App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
