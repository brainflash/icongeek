//
//  AppList.swift
//  IconGeek
//
//  Created by Brainflash on 27/10/2020.
//

import Foundation

// MARK: - Default apps

struct AppList {
	/// The default apps have to be opened by their respective URL schemes, where available
	static let URLs = [
		"com.apple.AppStore" 		: "itms-apps://itunes.apple.com",
		"com.apple.Music" 			: "music://",
		"com.apple.mobileslideshow" : "photos-redirect://",
		"com.apple.Preferences"		: "App-prefs:root",
	]

	// iOS 14 no longer allows opening specific pages of Settings app :-(
//	static let SettingsProfileListURL = "App-prefs:root=General&path=ManagedConfigurationList"
}

// MARK: - All apps

struct AppData: Identifiable, Codable  {
	var id: String
	var name: String
	var targetAppID: String			// Also known as the 'bundleID'
	var UUID: String = ""
	var appURL: String = " "		// Must not be zero-length

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case targetAppID
	}

	init(_ app: AppData, group: String) {
		self.id = app.id
		self.name = app.name
		self.targetAppID = app.targetAppID
		self.UUID = app.UUID
		self.appURL = app.appURL
	}
	
	init(id: String, name: String, targetAppID: String, UUID: String = "", appURL: String = "") {
		self.id = id
		self.name = name
		self.targetAppID = targetAppID
		if UUID != "" { self.UUID = UUID }
		if appURL != "" { self.appURL = appURL }
	}
	
	func isValid() -> Bool {
		// appURL and iconUUID must be present, otherwise the web clip configuration
		// will fail on installation ("profile corrupt" error)
		return (
			appURL != "" &&
			UUID != ""
		)
	}
}

extension AppData {
	static let IconGeekAppID = "com.brainflash.app.icongeek"

	static let blank = AppData(
		id: "blank",
		name: "Blank Icon",
		targetAppID: "undefined bundle ID"
	)
	
	// MARK: - Default apps
	
	static let appstore = AppData(
		id: "appstore",
		name: "App Store",
		targetAppID: IconGeekAppID,
		UUID: "4402090B-6219-461E-B2D4-4FA167425063",
		appURL: "icongeek://com.apple.AppStore"
	)
	
	static let music = AppData(
		id: "music",
		name: "Music",
		targetAppID: IconGeekAppID,
		UUID: "0359FE4C-3DAB-40F6-AA78-30869BE1D75D",
		appURL: "icongeek://com.apple.Music"
	)
	
	static let photos = AppData(
		id: "photos",
		name: "Photos",
		targetAppID: IconGeekAppID,
		UUID: "39F6DAC6-31B2-4FF5-AEE7-B858646370B8",
		appURL: "icongeek://com.apple.mobileslideshow"
	)
	
	static let settings = AppData(
		id: "settings",
		name: "Settings",
		targetAppID: IconGeekAppID,
		UUID: "156F878F-0BE5-43A5-A33B-75411D2E736B",
		appURL: "icongeek://com.apple.Preferences"
	)

	
	// MARK: - Third party apps
	
	static let facebook = 		AppData(id: "facebook", 	name: "Facebook", 	targetAppID: "com.facebook.Messenger", 		UUID: "CCDDE505-9953-4F3E-AAE5-E4DCFFF83869", 	appURL: "fb://")
	static let fbMessenger = 	AppData(id: "fbMessenger", 	name: "Messenger",	targetAppID: "com.facebook.Facebook", 		UUID: "87EAE7E3-B1DC-4AF9-B336-6A75388BD7A3", 	appURL: "fb-messenger://")
	static let kik = 			AppData(id: "kik", 			name: "Kik", 		targetAppID: "com.kik.chat", 				UUID: "71D52F2C-DE6A-496C-87DE-F18D4A1050EF", 	appURL: "kik://")
	static let instagram = 		AppData(id: "instagram",	name: "Instagram", 	targetAppID: "com.burbn.instagram", 		UUID: "658340D3-CFB0-4A4A-A47D-68C4F90348C2", 	appURL: " ")
	static let reddit = 		AppData(id: "reddit", 		name: "Reddit", 	targetAppID: "pinterest", 					UUID: "BD904A52-764F-43A7-A2E0-E60D34485649", 	appURL: " ")
	static let snapchat = 		AppData(id: "snapchat",		name: "Snapchat",	targetAppID: "com.toyopagroup.picaboo",		UUID: "81FC2076-AD22-4009-970A-2483CCF9D2AB",	appURL: "snapchat://")
	static let spotify = 		AppData(id: "spotify",		name: "Spotify",	targetAppID: "com.spotify.client",			UUID: "E8088781-2245-4175-9789-BABCD5889B5B",	appURL: "spotify://")
	static let tiktok = 		AppData(id: "tiktok",		name: "TikTok",		targetAppID: "com.zhiliaoapp.musically",	UUID: "2993B48D-4659-4E86-9261-276BCFE09A4A",	appURL: " ")
	static let whatsapp = 		AppData(id: "whatsapp",		name: "WhatsApp",	targetAppID: "net.whatsapp.WhatsApp",		UUID: "52CF4B70-CFD1-469B-A434-119E61AE2787",	appURL: " ")
	static let youtube = 		AppData(id: "youtube",		name: "YouTube",	targetAppID: "com.google.ios.youtube",		UUID: "6C177148-4532-4846-8176-6738C8B592BF",	appURL: " ")
}

extension AppList {
	static let all: [AppData] = [
		// Apple default apps
		.appstore,
		.music,
		.photos,
		.settings,
		
		// 3rd party
		.facebook,
		.fbMessenger,
		.kik,
		.instagram,
		.reddit,
		.snapchat,
		.spotify,
		.tiktok,
		.whatsapp,
		.youtube
	]
}
