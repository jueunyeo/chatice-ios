//
//  chatice_iosApp.swift
//  chatice-ios
//
//  Created by admin on 2/21/22.
//

import SwiftUI
import Firebase

@main
struct chatice_iosApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser != nil {
                MainView()
            } else {
                AuthIntroView()
            }
        }
        
         .onChange(of: scenePhase) { newScenePhase in
             switch newScenePhase {
             case .active:
                 print("active")
             case .inactive:
                 print("inactive")
             case .background:
                 print("background")
             @unknown default:
                 print("unknown")
             }
         }
         
        
    }
}
