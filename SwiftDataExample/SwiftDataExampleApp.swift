//
//  SwiftDataExampleApp.swift
//  SwiftDataExample
//
//  Created by Sachin Patoliya on 13/04/24.
//

import SwiftUI

@main
struct SwiftDataExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: [UserModel.self])
    }
}
