//
//  Foood_AppApp.swift
//  Foood App
//
//  Created by Agni Muhammad on 13/03/22.
//

import SwiftUI
import Firebase

@main
struct Foood_AppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
