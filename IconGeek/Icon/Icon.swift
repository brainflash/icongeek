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
	var bundleId: String
	var iconUUID: String? = ""
	var appURL: String? = ""

	// User variables
	var selected: Bool = true

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case bundleId
	}
	
	init(_ icon: Icon, group: String) {
		self.id = icon.id
		self.name = icon.name
		self.group = group
		self.bundleId = icon.bundleId
	}
	
	init(id: String, name: String, bundleId: String, iconUUID: String? = "", appURL: String? = "") {
		self.id = id
		self.name = name
		self.bundleId = bundleId
		self.iconUUID = iconUUID
		self.appURL = appURL
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
}
