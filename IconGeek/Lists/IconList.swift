//
//  IconList.swift
//  IconGeek
//
//  Created by Brainflash on 28/10/2020.
//

import Foundation

// MARK: - All icons

extension Icon {
	static let IconGeekAppID = "com.brainflash.icongeek"
	
	static let all: [Icon] = [
		// Apple default apps
		.appstore,
		.music,
		.photos,
		.settings,
		
		// 3rd party
		.facebook,
		.tiktok,
		.spotify
	]
	
	static let blank = Icon(
		id: "blank",
		name: "Blank Icon",
		targetAppID: "undefined bundle ID"
	)
	
	// MARK: - Default apps
	
	static let appstore = Icon(
		id: "appstore",
		name: "App Store",
		targetAppID: IconGeekAppID,
		UUID: "4402090B-6219-461E-B2D4-4FA167425063",
		appURL: "icongeek://com.apple.AppStore"
	)
	
	static let music = Icon(
		id: "music",
		name: "Music",
		targetAppID: IconGeekAppID,
		UUID: "0359FE4C-3DAB-40F6-AA78-30869BE1D75D",
		appURL: "icongeek://com.apple.Music"
	)
	
	static let photos = Icon(
		id: "photos",
		name: "Photos",
		targetAppID: IconGeekAppID,
		UUID: "39F6DAC6-31B2-4FF5-AEE7-B858646370B8",
		appURL: "icongeek://com.apple.mobileslideshow"
	)
	
	static let settings = Icon(
		id: "settings",
		name: "Settings",
		targetAppID: IconGeekAppID,
		UUID: "156F878F-0BE5-43A5-A33B-75411D2E736B",
		appURL: "icongeek://com.apple.Preferences"
	)

	
	// MARK: - Third party apps

	static let facebook = Icon(
		id: "facebook",
		name: "Facebook",
		targetAppID: "com.facebook.Facebook",
		UUID: "CCDDE505-9953-4F3E-AAE5-E4DCFFF83869",
		appURL: "fb://"
	)
	
	static let spotify = Icon(
		id: "spotify",
		name: "Spotify",
		targetAppID: "com.spotify.client",
		UUID: "E8088781-2245-4175-9789-BABCD5889B5B",
		appURL: "spotify://"
	)
	
	static let tiktok = Icon(
		id: "tiktok",
		name: "TikTok",
		targetAppID: "com.zhiliaoapp.musically",
		UUID: "2993B48D-4659-4E86-9261-276BCFE09A4A",
		appURL: " "
	)
}
