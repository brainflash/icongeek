//
//  IconGeekModel.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import Foundation

class AppModel: ObservableObject {
}

// MARK: - IconGeek API

extension AppModel {
	func addToHomeScreen(_ iconSet: IconSet) {
		// 1. Generate the .mobileconfig file
		let mobileConfig = generateMobileConfig(iconSet)
		
		// 2. Upload the mobile config for signing
		NSLog("mobileconfig generated")
	}
}
