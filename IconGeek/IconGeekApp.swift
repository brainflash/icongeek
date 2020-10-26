//
//  IconGeekApp.swift
//  IconGeek
//
//  Created by Brainflash on 23/10/2020.
//

import SwiftUI

@main
struct IconGeekApp: App {
	@StateObject private var model = AppModel()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(model)
        }
    }
}
