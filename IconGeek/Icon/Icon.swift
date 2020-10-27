//
//  Icon.swift
//  IconGeek
//
//  Created by Brainflash on 25/10/2020.
//

struct Icon: Identifiable, Codable {
	var id: String
	var name: String
	var group: String = ""
	var targetAppID: String			// Also known as the 'bundleID'
	var iconUUID: String = ""
	var appURL: String = ""

	// User variables
	var selected: Bool = true

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
		self.iconUUID = icon.iconUUID
		self.appURL = icon.appURL
	}
	
	init(id: String, name: String, targetAppID: String, iconUUID: String = "", appURL: String = "") {
		self.id = id
		self.name = name
		self.targetAppID = targetAppID
		if iconUUID != "" { self.iconUUID = iconUUID }
		if appURL != "" { self.appURL = appURL }
	}
}

extension Icon {
	static let all: [Icon] = [
		.appstore,
		.music,
		.photos,
		.facebook
	]
	
	static func allWithGroup(_ group: String) -> [Icon] {
		var icons: [Icon] = []
		Icon.all.forEach { (icon) in
			let icon = Icon(icon, group: group)
			icons.append(icon)
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
//			appURL != "" &&
			iconUUID != ""
		)
	}
}
