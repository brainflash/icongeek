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
	var iconsBackground: Color
	
	var options: Dictionary<String, Any>
	struct IconSetOptions {
		var foregroundColor: Color = Color.appForeground
		var backgroundColor: Color = Color.appBackground
		var iconBackground: Color = Color.iconBackground
		var tintColor: Color = Color.white
	}
	var display = IconSetOptions()
	
	init(id: String, title: String, group: String, UUID: String, isLocked: Bool, options: Dictionary<String, Any>? = nil) {
		self.id = id
		self.title = title
		self.group = group
		self.UUID = UUID
		self.isLocked = isLocked
		self.icons = Icon.allWithGroup(group)
		self.options = options ?? [:]
		self.display.foregroundColor = self.options["foreground"] as? Color ?? Color.appForeground
		self.display.backgroundColor = self.options["background"] as? Color ?? Color.appBackground
		self.display.iconBackground = self.options["icon-background"] as? Color ?? Color.iconBackground
		self.display.tintColor = self.options["tint"] as? Color ?? Color.appTint
		
		/// The user-chosen colour that will be applied to the generated icons
		self.iconsBackground = self.display.iconBackground
	}
}

// MARK: - Icon Set API

extension IconSet {
	func isValid() -> Bool {
		return UUID != ""
	}
	
	/// Returns an array of Icons that are selected
	var selected: [Icon] {
		icons.filter { icon in
			icon.selected
		}
	}
}

// MARK: - Icon Sets

extension IconSet {
	static let all: [IconSet] = [
		.iconSet2,		// Cute Color
		.iconSet1,		// Doodle
		.iconSet3,		// Gradient Line
		.iconSet4		// Dotty
	]
	
	static let defaultSet: IconSet = .iconSet1
	
	static let iconSet1 = IconSet(
		id: "app.icongeek.iconset1",
		title: "Doodle",
		group: "icon-set-1",
		UUID: "5A952F19-0ECD-4781-ABF4-9A1AA89BD02F",
		isLocked: true
	)
	
	static let iconSet2 = IconSet(
		id: "app.icongeek.iconset2",
		title: "Cute Color",
		group: "icon-set-2-cutecolor",
		UUID: "01832E06-B08F-4935-A916-0A2AD7B81BE5",
		isLocked: false
	)

	static let iconSet3 = IconSet(
		id: "app.icongeek.iconset3",
		title: "Gradient Line",
		group: "icon-set-3-gradient",
		UUID: "C88F3187-FF2D-4BA8-84C6-B0519A682CED",
		isLocked: true,
		options: [
			"foreground": Color.white,
			"background": Color.black,
			"icon-background": Color.black,
			"tint": Color.purple
		]
	)
	
	static let iconSet4 = IconSet(
		id: "app.icongeek.iconset4",
		title: "Dotty",
		group: "icon-set-4-dotty",
		UUID: "E58F53CD-CA0C-424C-BADA-C1CA434D7A9D",
		isLocked: true,
		options: [
			"icon-background": Color.white,
			"background": Color.gray
		]
	)

}
