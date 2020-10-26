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
		bundleId: "undefined bundle ID"
	)
	
	// MARK: - Default apps
	
	static let appstore = Icon(
		id: "appstore",
		name: "App Store",
		bundleId: "com.apple.AppStore",
		iconUUID: "fd8a6b9e-0fed-406f-9571-8ec98722b713"
	)
	
	static let music = Icon(
		id: "music",
		name: "Music",
		bundleId: "com.apple.Music",
		iconUUID: "ed8a6b9e-0fed-406f-9571-8ec98722b713",
		appURL: "music://"
	)
	
	static let photos = Icon(
		id: "photos",
		name: "Photos",
		bundleId: "com.apple.mobileslideshow",
		iconUUID: "dd8a6b9e-0fed-406f-9571-8ec98722b713",
		appURL: "photos://"
	)
	
	// MARK: - Third party apps

	static let facebook = Icon(
		id: "facebook",
		name: "Facebook",
		bundleId: "com.facebook.Facebook",
		iconUUID: "cd8a6b9e-0fed-406f-9571-8ec98722b713"
	)

}
