//
//  AppModel+MobileConfig.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import Foundation
import UIKit

// Placeholder constants
// –––––––––––––––––––––––––
// Configuration Profile
// IG_PROFILE_NAME
// IG_ICONSET_UUID
//
// Web Clips
// IG_SHORTCUT_NAME
// IG_ICON_UUID
// IG_APP_URL
// IG_TARGET_APP_ID


let IconGeekMobileConfigHeader = """
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\
<plist version="1.0"><dict>\
<key>PayloadContent</key>\
<array>
"""

let IconGeekMobileConfigFooter = """
</array>\
<key>PayloadDescription</key><string>Icon Geek Web Clip</string>\
<key>PayloadDisplayName</key><string>{IG_PROFILE_NAME}</string>\
<key>PayloadIdentifier</key><string>profiles.icongeek.app.webclip</string>\
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
<key>PayloadDisplayName</key><string>Web Clip (IconGeek)</string>\
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
	func generateMobileConfig(_ iconSet: IconSet) -> String {
		var mobileconfig = String(IconGeekMobileConfigHeader)
		
		if iconSet.isValid() == false {
			NSLog("ERROR! -->  iconSet not valid, UUID: '\(iconSet.UUID)'")
		}
		
		iconSet.icons.forEach { icon in
			if let image = UIImage(named: icon.imageName) {
				if icon.isValid() {
					if let imageData = image.pngData() {
						mobileconfig.append(IconGeekWebClipHeader)
						mobileconfig.append(imageData.base64EncodedString())
						var webClip = String(IconGeekWebClip)
						webClip = webClip.replacingOccurrences(of: "{IG_SHORTCUT_NAME}", with: icon.name)
						webClip = webClip.replacingOccurrences(of: "{IG_ICON_UUID}", with: icon.UUID)
						webClip = webClip.replacingOccurrences(of: "{IG_APP_URL}", with: icon.appURL)
						webClip = webClip.replacingOccurrences(of: "{IG_TARGET_APP_ID}", with: icon.targetAppID)
						mobileconfig.append(webClip)
					} else {
						NSLog("ERROR! -->  get pngData failed for '\(icon.imageName)'")
					}
				} else {
					NSLog("ERROR! -->  icon data not valid for '\(icon.name)'")
				}
			} else {
				NSLog("ERROR! -->  Icon with image name '\(icon.imageName)' not found")
			}
		}
		
		var footer = String(IconGeekMobileConfigFooter)
		footer = footer.replacingOccurrences(of: "{IG_ICONSET_UUID}", with: iconSet.UUID)
//		footer = footer.replacingOccurrences(of: "{IG_PROFILE_NAME}", with: "Icon Geek")
		footer = footer.replacingOccurrences(of: "{IG_PROFILE_NAME}", with: "\(iconSet.title) Icon Set")
		mobileconfig.append(footer)
		
		return mobileconfig
	}
}
