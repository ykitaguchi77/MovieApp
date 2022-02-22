//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Yoshiyuki Kitaguchi on 2022/02/22.
//

import SwiftUI

@main
struct MovieAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
