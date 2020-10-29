//
//  AppModel+MobileConfig.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import Foundation
import UIKit

let IconGeekMobileConfigHeader = """
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\
<plist version="1.0"><dict>\
<key>PayloadContent</key>\
<array>
"""

let IconGeekMobileConfigFooter = """
</array>\
<key>PayloadDescription</key><string>{IG_PROFILE_DESCRIPTION}</string>\
<key>PayloadDisplayName</key><string>{IG_PROFILE_NAME}</string>\
<key>PayloadIdentifier</key><string>{IG_PROFILE_IDENTIFIER}</string>\
<key>PayloadOrganization</key><string>Icon Geek App</string>\
<key>PayloadRemovalDisallowed</key><false/>\
<key>PayloadType</key><string>Configuration</string>\
<key>PayloadUUID</key><string>{IG_ICONSET_UUID}</string>\
<key>PayloadVersion</key><integer>1</integer>\
</dict>\
</plist>
"""

let IconGeekWebClipHeader = """
<dict>\
<key>FullScreen</key><true/>\
<key>Icon</key><data>
"""

let IconGeekWebClip = """
</data>\
<key>IsRemovable</key><true/>\
<key>Label</key><string>{IG_SHORTCUT_NAME}</string>\
<key>PayloadDescription</key><string>Configures Web Clip</string>\
<key>PayloadDisplayName</key><string>{IG_SHORTCUT_DISPLAY_NAME}</string>\
<key>PayloadIdentifier</key><string>profiles.icongeek.app</string>\
<key>PayloadOrganization</key><string>Icon Geek</string>\
<key>PayloadType</key><string>com.apple.webClip.managed</string>\
<key>PayloadUUID</key><string>{IG_ICON_UUID}</string>\
<key>PayloadVersion</key><integer>1</integer>\
<key>URL</key><string>{IG_APP_URL}</string>\
<key>TargetApplicationBundleIdentifier</key><string>{IG_TARGET_APP_ID}</string>\
<key>Precomposed</key><true/>\
</dict>
"""


extension AppModel {
	struct Keys {
		// Configuration Profile
		static let IG_PROFILE_NAME = "{IG_PROFILE_NAME}"
		static let IG_PROFILE_DESCRIPTION = "{IG_PROFILE_DESCRIPTION}"
		static let IG_PROFILE_IDENTIFIER = "{IG_PROFILE_IDENTIFIER}"
		static let IG_ICONSET_UUID = "{IG_ICONSET_UUID}"
		
		// Web Clips
		static let IG_SHORTCUT_NAME = "{IG_SHORTCUT_NAME}"
		/// This is the name displayed in the titlebar in Settings > Profile > (Icon Set Name) > More Details > Web Clip
		static let IG_SHORTCUT_DISPLAY_NAME = "{IG_SHORTCUT_DISPLAY_NAME}"
		static let IG_ICON_UUID = "{IG_ICON_UUID}"
		static let IG_APP_URL = "{IG_APP_URL}"
		static let IG_TARGET_APP_ID = "{IG_TARGET_APP_ID}"
	}
	
	func generateMobileConfig(_ iconSet: IconSet) -> String {
		var mobileconfig = String(IconGeekMobileConfigHeader)
		
		if iconSet.isValid() == false {
			NSLog("ERROR! -->  iconSet not valid, UUID: '\(iconSet.UUID)'")
		}
		
		let selected = iconSet.selected
		guard !selected.isEmpty else { return "" }
		
		selected.forEach { icon in
			// Create a UIImage with the background color of the icon set and icon image overlaid
			if let iconImage = UIImage(named: icon.imageName),
			   // TODO: add a max image size parameter + scale down. Some icons are 256x256 which is more than supported icon size of 144x144
			   let image = UIImage(color: UIColor(iconSet.iconsBackground), image: iconImage, scale: 1) {
				
				let app = icon.app
				if app.isValid() {
					if let imageData = image.pngData() {
						mobileconfig.append(IconGeekWebClipHeader)
						mobileconfig.append(imageData.base64EncodedString())
						var webClip = String(IconGeekWebClip)
						webClip = webClip.replacingOccurrences(of: Keys.IG_SHORTCUT_NAME, with: icon.name)
						webClip = webClip.replacingOccurrences(of: Keys.IG_SHORTCUT_DISPLAY_NAME, with: "Web Clip (\(app.name))")
						webClip = webClip.replacingOccurrences(of: Keys.IG_ICON_UUID, with: app.UUID)
						webClip = webClip.replacingOccurrences(of: Keys.IG_APP_URL, with: app.appURL)
						webClip = webClip.replacingOccurrences(of: Keys.IG_TARGET_APP_ID, with: app.targetAppID)
						mobileconfig.append(webClip)
					} else {
						NSLog("ERROR! -->  get pngData failed for '\(icon.imageName)'")
					}
				} else {
					NSLog("ERROR! -->  icon data not valid for '\(app.name)'")
				}
			} else {
				NSLog("ERROR! -->  Icon with image name '\(icon.imageName)' not found")
			}
		}
		
		var footer = String(IconGeekMobileConfigFooter)
		footer = footer.replacingOccurrences(of: Keys.IG_ICONSET_UUID, with: iconSet.UUID)
		let iconCount = "\(selected.count)" + (selected.count > 1 ? " icons" : " icon")
		footer = footer.replacingOccurrences(of: Keys.IG_PROFILE_NAME, with: "\(iconSet.title) Icon Set (\(iconCount))")
		footer = footer.replacingOccurrences(of: Keys.IG_PROFILE_DESCRIPTION, with: "Icon Geek Shortcuts")
		// Option here to add a random ID to the profileID. This makes the icon set install as a new set and so previous set not replaced.
//		let profileID = "\(iconSet.id).\(String.randomString(8))"
		let profileID = "\(iconSet.id)"
		footer = footer.replacingOccurrences(of: Keys.IG_PROFILE_IDENTIFIER, with: profileID)
		mobileconfig.append(footer)
		
		return mobileconfig
	}
}
