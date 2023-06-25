//
//  DontDoAppApp.swift
//  DontDoApp
//
//  Created by Nesim Tunç on 2023/06/25.
//

import SwiftUI
import SwiftData

@main
struct DontDoAppApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
