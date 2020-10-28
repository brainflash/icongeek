//
//  Icon.swift
//  IconGeek
//
//  Created by Brainflash on 25/10/2020.
//

import SwiftUI

class Icon: ObservableObject, Identifiable, Codable {
	var id: String
	var name: String
	var group: String = ""
	var targetAppID: String			// Also known as the 'bundleID'
	var UUID: String = ""
	var appURL: String = " "		// Must not be zero-length

	// User variables
	@Published var selected: Bool = false

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case targetAppID
	}
	
	init(_ icon: Icon, group: String) {
		self.id = icon.id
		self.name = icon.name
		self.group = group
		self.targetAppID = icon.targetAppID
		self.UUID = icon.UUID
		self.appURL = icon.appURL
	}
	
	init(id: String, name: String, targetAppID: String, UUID: String = "", appURL: String = "") {
		self.id = id
		self.name = name
		self.targetAppID = targetAppID
		if UUID != "" { self.UUID = UUID }
		if appURL != "" { self.appURL = appURL }
	}
}

extension Icon {
	static func allWithGroup(_ group: String) -> [Icon] {
		var icons: [Icon] = []
		Icon.all.forEach { (icon) in
			let icon = Icon(icon, group: group)
			let exists = icon.imageExists
			if !exists {
				NSLog("No icon with asset name \(icon.imageName)")
			}
			if icon.isValid() && exists {
				icons.append(icon)
			}
		}
		return icons
	}
	
	var imageName: String {
		"\(group)/\(name)"
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
