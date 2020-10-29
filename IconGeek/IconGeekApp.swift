//
//  IconGeekApp.swift
//  IconGeek
//
//  Created by Brainflash on 23/10/2020.
//

import SwiftUI

@main
struct IconGeekApp: App {
	@Environment(\.openURL) var openURL
	
	@StateObject private var model = AppModel()
	@StateObject private var store = Store()

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(model)
				.onOpenURL { url in
					if let host = url.host, let appURL = AppList.URLs[host] {
						openURL.callAsFunction(URL(string: appURL)!) { accepted in
							if accepted {
								NSLog("App opened successfully")
							} else {
								NSLog("Unable to open custom URL: \(url)")
							}
						}
					} else {
						NSLog("Unable to open custom URL: \(url)")
					}
					
					// Supsends the app (but prevents openURL from working)
//					UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
					
					// Used by XCTest to simulate device buttons
//					XCUIDevice.shared.press(.home)
				}
        }
    }
}
