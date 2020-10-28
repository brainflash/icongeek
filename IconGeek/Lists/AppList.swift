//
//  AppList.swift
//  IconGeek
//
//  Created by Brainflash on 27/10/2020.
//

import Foundation

struct AppList {
	static let URLs = [
		"com.apple.AppStore" 		: "itms-apps://itunes.apple.com",
		"com.apple.Music" 			: "music://",
		"com.apple.mobileslideshow" : "photos-redirect://",
		"com.apple.Preferences"		: "App-prefs:root",
	]

	// iOS 14 no longer allows opening specific pages of Settings app :-(
//	static let SettingsProfileListURL = "App-prefs:root=General&path=ManagedConfigurationList"
}
