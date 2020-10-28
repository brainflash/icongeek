//
//  IconSet.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import SwiftUI

// TODO: make IconSet comply with Codable (change or handle the 'Any' in options dict)
// struct IconSet: Identifiable, Codable {

struct IconSet: Identifiable {
	var id: String
	var title: String
	var group: String
	var UUID: String
	var isLocked = false
	var background: String = "default"
	var icons: [Icon]
	
	var options: Dictionary<String, Any>
	struct IconSetOptions {
		var foregroundColor: Color?
		var backgroundColor: Color?
	}
	var display = IconSetOptions()
	
	init(id: String, title: String, group: String, UUID: String, isLocked: Bool, options: Dictionary<String, Any>?) {
		self.id = id
		self.title = title
		self.group = group
		self.UUID = UUID
		self.isLocked = isLocked
		self.icons = Icon.allWithGroup(group)
		self.options = options ?? [:]
		self.display.foregroundColor = self.options["foreground"] as? Color ?? Color.primary
		self.display.backgroundColor = self.options["background"] as? Color ?? Color.appBackground
	}
}

// MARK: - Icon Set API

extension IconSet {
	func isValid() -> Bool {
		return UUID != ""
	}
}

// MARK: - Icon Sets

extension IconSet {
	static let all: [IconSet] = [
		.iconSet2,
		.iconSet1,
		.iconSet3
	]
	
	static let defaultSet: IconSet = .iconSet1
	
	static let iconSet1 = IconSet(
		id: "icon-set-1",
		title: "Doodle",
		group: "icon-set-1",
		UUID: "5A952F19-0ECD-4781-ABF4-9A1AA89BD02F",
		isLocked: true,
		options: nil
	)
	
	static let iconSet2 = IconSet(
		id: "icon-set-2",
		title: "Cute Color",
		group: "icon-set-2",
		UUID: "01832E06-B08F-4935-A916-0A2AD7B81BE5",
		isLocked: false,
		options: nil
	)

	static let iconSet3 = IconSet(
		id: "icon-set-3",
		title: "Gradient Line",
		group: "icon-set-3",
		UUID: "C88F3187-FF2D-4BA8-84C6-B0519A682CED",
		isLocked: true,
		options: [
			"foreground": Color.white,
			"background": Color.black,
			"tintColor": Color.purple
		]
	)

}
