//
//  AppModel+MobileConfig.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import Foundation

let IconGeekMobileConfigHeader = """
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
	<key>PayloadContent</key>
	<array>
"""

let IconGeekMobileConfigFooter = """
	</array>
<key>PayloadDescription</key><string>Icon Geek Web Clip</string>
<key>PayloadDisplayName</key><string>Icon Geek</string>
<key>PayloadIdentifier</key><string>profiles.icongeek.app.webclip</string>
<key>PayloadOrganization</key><string>Icon Geek App</string>
<key>PayloadRemovalDisallowed</key><false/>
<key>PayloadType</key><string>Configuration</string>
<key>PayloadUUID</key><string>fd8a6b9e-0fed-406f-9571-8ec98722b713</string>
<key>PayloadVersion</key><integer>1</integer>
</dict>
</plist>
"""

let IconGeekWebClip = """
	<dict>
	<key>FullScreen</key><true/>
	<key>Icon</key><data>
		{IG_ICON_DATA}
	</data>
	<key>IsRemovable</key><true/>
	<key>Label</key><string>{IG_SHORTCUT_NAME}</string>
	<key>PayloadDescription</key><string>Configures Web Clip</string>
	<key>PayloadDisplayName</key><string>Web Clip (IconGeek)</string>
	<key>PayloadIdentifier</key><string>profiles.icongeek.app</string>
	<key>PayloadOrganization</key><string>Icon Geek</string>
	<key>PayloadType</key><string>com.apple.webClip.managed</string>
	<key>PayloadUUID</key><string>{IG_ICON_UUID}</string>
	<key>PayloadVersion</key><integer>1</integer>
	<key>URL</key><string>message://</string>
	<key>TargetApplicationBundleIdentifier</key><string>{IG_TARGET_APP_ID}</string>
	<key>Precomposed</key><true/>
	</dict>
"""


extension AppModel {
	func generateMobileConfig(_ iconSet: IconSet) -> String {
		var mobileconfig = String(IconGeekMobileConfigHeader)
		mobileconfig.append(IconGeekTestClip1)
		mobileconfig.append(IconGeekMobileConfigFooter)
		return mobileconfig
	}
}
