//
//  Icon+SwiftUI.swift
//  IconGeek
//
//  Created by Brainflash on 25/10/2020.
//

import SwiftUI

// MARK: - SwiftUI

extension Icon {
	
	/// The image for this icon
	var image: Image {
		Image("\(group)/\(name)", label: Text(name))
			.renderingMode(.original)
	}
}

// MARK: - All icons

extension Icon {
	static let blank = Icon(
		id: "blank",
		name: "Blank Icon",
		targetAppID: "undefined bundle ID"
	)
	
	// MARK: - Default apps
	
	static let appstore = Icon(
		id: "appstore",
		name: "App Store",
		targetAppID: "com.apple.AppStore",
		iconUUID: "fd8a6b9e-0fed-406f-9571-8ec98722b713",
		appURL: "itms-apps://"
		
	)
	
	static let music = Icon(
		id: "music",
		name: "Music",
		targetAppID: "com.apple.Music",
		iconUUID: "ed8a6b9e-0fed-406f-9571-8ec98722b713",
		appURL: "music://"
	)
	
	static let photos = Icon(
		id: "photos",
		name: "Photos",
		targetAppID: "com.apple.mobileslideshow",
		iconUUID: "dd8a6b9e-0fed-406f-9571-8ec98722b713",
		appURL: "photos://"
	)
	
	// MARK: - Third party apps

	static let facebook = Icon(
		id: "facebook",
		name: "Facebook",
		targetAppID: "com.facebook.Facebook",
		iconUUID: "cd8a6b9e-0fed-406f-9571-8ec98722b713",
		appURL: "fb://"
	)

}
