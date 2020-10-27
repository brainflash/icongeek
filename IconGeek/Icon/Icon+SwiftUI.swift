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
		UUID: "4402090B-6219-461E-B2D4-4FA167425063",
		appURL: "itms-apps://itunes.apple.com"
	)
	
	static let music = Icon(
		id: "music",
		name: "Music",
		targetAppID: "com.apple.Music",
		UUID: "0359FE4C-3DAB-40F6-AA78-30869BE1D75D",
		appURL: "music://"
	)
	
	static let photos = Icon(
		id: "photos",
		name: "Photos",
		targetAppID: "com.apple.mobileslideshow",
		UUID: "39F6DAC6-31B2-4FF5-AEE7-B858646370B8",
		appURL: "photos-redirect://"
	)
	
	// MARK: - Third party apps

	static let facebook = Icon(
		id: "facebook",
		name: "Facebook",
		targetAppID: "com.facebook.Facebook",
		UUID: "CCDDE505-9953-4F3E-AAE5-E4DCFFF83869",
		appURL: "fb://"
	)

}