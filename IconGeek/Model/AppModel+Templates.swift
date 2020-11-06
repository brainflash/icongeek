//
//  AppModel+Templates.swift
//  IconGeek
//
//  Created by Brainflash on 05/11/2020.
//

import Foundation

extension AppModel {
	static let ConfigHeader = """
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\
	<plist version="1.0"><dict>\
	<key>PayloadContent</key>\
	<array>
	"""

	static let ConfigFooter = """
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

	static let WebClipHeader = """
	<dict>\
	<key>FullScreen</key><true/>\
	<key>Icon</key><data>
	"""

	static let WebClip = """
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
}
