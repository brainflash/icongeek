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
		"com.apple.iBooks"			: "ibooks://",
		"com.apple.itunesu"			: "itms-itunesu://",
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
	static let IconGeekAppID = "app.icongeek"

	static let blank = AppData(
		id: "blank",
		name: "Blank Icon",
		targetAppID: "undefined bundle ID"
	)
	
	// MARK: - Default/Apple apps
	
	static let appstore = AppData(
		id: "appstore",
		name: "App Store",
		targetAppID: IconGeekAppID,
		UUID: "4402090B-6219-461E-B2D4-4FA167425063",
		appURL: "icongeek://com.apple.AppStore"
	)

	// Books: com.apple.iBooks
	// iTunes U: com.apple.itunesu
	
	static let books = 			AppData(id: "books", 		name: "Books", 			targetAppID: IconGeekAppID, 					UUID: "1DAA8479-2CAB-4A43-AB07-3D4D72FA98BF", 	appURL: "icongeek://com.apple.iBooks")
	static let itunesu = 		AppData(id: "itunesu",		name: "iTunes U",		targetAppID: IconGeekAppID,						UUID: "7864113D-31A4-4467-B7F2-79C19EF98F0B",	appURL: "icongeek://com.apple.itunesu")
	static let music = 			AppData(id: "music",		name: "Music",			targetAppID: IconGeekAppID,						UUID: "0359FE4C-3DAB-40F6-AA78-30869BE1D75D",	appURL: "icongeek://com.apple.Music")

	// TODO:
//  Apple Arcade
//	calendar
//  camera
//	clock
//  Facetime
//  iTunes U
//	mail
//  maps
//  messages
//	news
//  notes
//  reminders
//  Safari
//  shortcuts
// 	Health
//	weather
//  Videos
	
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
	static let amazon =			AppData(id: "amazon",			name: "Amazon",			targetAppID: "com.amazon.Amazon",				UUID: "A0273876-5214-444C-9988-E06A328A2574",	appURL: " ")
//  amazon music
//	chrome
//	dribble
//  dropbox
	static let facebook = 		AppData(id: "facebook", 		name: "Facebook", 		targetAppID: "com.facebook.Facebook", 			UUID: "CCDDE505-9953-4F3E-AAE5-E4DCFFF83869", 	appURL: "fb://")
	static let fbMessenger = 	AppData(id: "fbMessenger", 		name: "Messenger",		targetAppID: "com.facebook.Messenger", 			UUID: "87EAE7E3-B1DC-4AF9-B336-6A75388BD7A3", 	appURL: "fb-messenger://")
	static let firefox =		AppData(id: "firefox",			name: "Firefox", 		targetAppID: "org.mozilla.ios.Firefox",			UUID: "1BCAB38B-1A32-4C06-BAA7-05E842FB6DEC",	appURL: " ")
//	gmail
// google
	static let houseparty = 	AppData(id: "houseparty",		name: "Houseparty", 	targetAppID: "com.herzick.houseparty", 			UUID: "9721B0FF-97F5-44EC-89A3-2943C94765E3",	appURL: " ")
	static let instagram = 		AppData(id: "instagram",		name: "Instagram", 		targetAppID: "com.burbn.instagram", 			UUID: "658340D3-CFB0-4A4A-A47D-68C4F90348C2", 	appURL: " ")
	static let kik = 			AppData(id: "kik", 				name: "Kik", 			targetAppID: "com.kik.chat", 					UUID: "71D52F2C-DE6A-496C-87DE-F18D4A1050EF", 	appURL: "kik://")
	static let linkedIn =		AppData(id: "linkedin",			name: "LinkedIn",		targetAppID: "com.linkedin.LinkedIn",			UUID: "5FD2F0C5-0A82-4BDA-BF5D-2C243E5A57A7", 	appURL: " ")
// Napster
// Netflix
	static let pinterest = 		AppData(id: "pinterest", 		name: "Pinterest", 		targetAppID: "pinterest", 						UUID: "1D9FF76A-C419-4243-B6EE-3FFE48C3B9DC", 	appURL: " ")
	static let reddit = 		AppData(id: "reddit", 			name: "Reddit", 		targetAppID: "com.reddit.Reddit",				UUID: "BD904A52-764F-43A7-A2E0-E60D34485649", 	appURL: " ")
//	skype
	static let snapchat = 		AppData(id: "snapchat",			name: "Snapchat",		targetAppID: "com.toyopagroup.picaboo",			UUID: "81FC2076-AD22-4009-970A-2483CCF9D2AB",	appURL: "snapchat://")
	static let spotify = 		AppData(id: "spotify",			name: "Spotify",		targetAppID: "com.spotify.client",				UUID: "E8088781-2245-4175-9789-BABCD5889B5B",	appURL: "spotify://")
	static let telegram =		AppData(id: "telegram",			name: "Telegram",		targetAppID: "ph.telegra.Telegraph",			UUID: "7EDE3D28-13EE-4E28-AB7E-9629BA986E60",	appURL: " ")
	static let tiktok = 		AppData(id: "tiktok",			name: "TikTok",			targetAppID: "com.zhiliaoapp.musically",		UUID: "2993B48D-4659-4E86-9261-276BCFE09A4A",	appURL: " ")
	static let tinder = 		AppData(id: "tinder",			name: "Tinder",			targetAppID: "com.cardify.tinder",				UUID: "5ABB45B3-0AB5-4FCE-8FDC-8678E6576078",	appURL: " ")
	// TODO: double-check the URL scheme for Twitter
	static let twitter = 		AppData(id: "twitter",			name: "Twitter",		targetAppID: "com.atebits.Tweetie2",			UUID: "4F170508-1200-48F9-A8EC-8C95D331C5B0",	appURL: "twitter://")

//	unsplash
	static let whatsapp = 		AppData(id: "whatsapp",			name: "WhatsApp",		targetAppID: "net.whatsapp.WhatsApp",			UUID: "52CF4B70-CFD1-469B-A434-119E61AE2787",	appURL: " ")
	static let youtube = 		AppData(id: "youtube",			name: "YouTube",		targetAppID: "com.google.ios.youtube",			UUID: "6C177148-4532-4846-8176-6738C8B592BF",	appURL: " ")
	static let youtubemusic = 	AppData(id: "youtubemusic",		name: "YouTube Music",	targetAppID: "com.google.ios.youtubemusic",		UUID: "0E224B91-5B1A-497D-84D2-2D8E9DD16D1C",	appURL: " ")
//	waze
//	zoom
	// TODO: get the proper data for these ones:
	static let zoom = 	AppData(id: "zoom",		name: "Zoom",	targetAppID: "app.icongeek",		UUID: "AE224B91-5B1A-497D-84D2-2D8E9DD16D1C",	appURL: " ")
	static let shortcuts = 	AppData(id: "shortcuts",		name: "Shortcuts",	targetAppID: "app.icongeek",		UUID: "BE224B91-5B1A-497D-84D2-2D8E9DD16D1C",	appURL: " ")
	static let jetpackjoyride = 	AppData(id: "jetpackjoyride",		name: "Jetpack Joyride",	targetAppID: "app.icongeek",		UUID: "CE224B91-5B1A-497D-84D2-2D8E9DD16D1C",	appURL: " ")
	static let camera = 	AppData(id: "camera",		name: "Camera",	targetAppID: "app.icongeek",		UUID: "DE224B91-5B1A-497D-84D2-2D8E9DD16D1C",	appURL: " ")
	static let health = 	AppData(id: "health",		name: "Health",	targetAppID: "app.icongeek",		UUID: "E18CC373-AC76-4DFB-A674-59A0D10A2A7E",	appURL: " ")
	static let calculator = 	AppData(id: "calculator",		name: "Calculator",	targetAppID: "app.icongeek",		UUID: "FE9D4DDA-DE1C-4DA1-BA95-10A89D65B99B",	appURL: " ")
	static let vimeo = 	AppData(id: "vimeo",		name: "Vimeo",	targetAppID: "app.icongeek",		UUID: "C08954FE-D280-4F5E-BBB7-E949B3F216B2",	appURL: " ")
	static let safari = 	AppData(id: "safari",		name: "Safari",	targetAppID: "app.icongeek",		UUID: "9B520E82-27C0-4FA0-8FBE-F99B78D1FDDF",	appURL: " ")
	static let notes = 	AppData(id: "notes",		name: "Notes",	targetAppID: "app.icongeek",		UUID: "40C4EFF6-B4E9-4A25-BC53-B0DE301AA7AC",	appURL: " ")

	
	// MARK: - Games
	
	static let amongus =		AppData(id: "amongus",		name: "Among Us",	targetAppID: "com.innersloth.amongus",		UUID: "10EADC3A-0FF4-436B-BD78-89E1FFC4356B",	appURL: " ")
	// Artwork URL: https://is2-ssl.mzstatic.com/image/thumb/Purple114/v4/d5/14/a7/d514a7fb-69e6-7519-e753-2527d12939f1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png
//	steam
	
	
//	static let steve
}

extension AppList {
	static let all: [AppData] = [
		// Apple default apps
		.appstore,
		.books,
		.itunesu,
		.music,
		.photos,
		.settings,
		
		// 3rd party
		.amazon,
		.facebook,
		.fbMessenger,
		.firefox,
		.houseparty,
		.instagram,
		.kik,
		.linkedIn,
		.pinterest,
		.reddit,
		.snapchat,
		.spotify,
		.telegram,
		.tiktok,
		.tinder,
		.twitter,
		.whatsapp,
		.youtube,
		.youtubemusic,
		
		// TODO: these apps have dummy info, need to update
		.shortcuts,
		.zoom,
		.jetpackjoyride,
		.camera,
		.health,
		.calculator,
		.vimeo,
		.safari,
		.notes,

		// Games
		.amongus,
//		.steve
	]
	
	// The 'default' built-in apps that can't be opened by app ID (i.e. Apple apps)
	static let defaultApps: [AppData] = [
		.appstore,
		.books,
		.itunesu,
		.music,
		.photos,
		.settings
	]
}
