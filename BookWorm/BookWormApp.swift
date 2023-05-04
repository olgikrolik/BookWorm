//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Olga Królikowska on 30/03/2023.
//

import SwiftUI

@main
struct BookWormApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Montserrat-Light" , size: 34)!]
    }
    
    var body: some Scene {
        WindowGroup {
            BestsellersListView()
        }
    }
}
