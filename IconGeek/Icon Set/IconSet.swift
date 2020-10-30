//
//  IconSet.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import SwiftUI
import Combine

// TODO: make IconSet comply with Codable (change or handle the 'Any' in options dict)
// struct IconSet: Identifiable, Codable {

class IconSet: ObservableObject, Identifiable {
	@Published var icons: [Icon] = []
	@Published var isLocked = false
	var cancellables = [AnyCancellable]()
	
	var id: String
	var title: String
	var group: String
	var UUID: String
	
	var background: String = "default"
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
		self.options = options ?? [:]
		self.display.foregroundColor = self.options["foreground"] as? Color ?? Color.appForeground
		self.display.backgroundColor = self.options["background"] as? Color ?? Color.appBackground
		self.display.iconBackground = self.options["icon-background"] as? Color ?? Color.iconBackground
		self.display.tintColor = self.options["tint"] as? Color ?? Color.appTint
		
		/// The user-chosen colour that will be applied to the generated icons
		self.iconsBackground = self.display.iconBackground

		self.icons = Icon.allWithGroup(group)
		self.icons.forEach({
			let c = $0.objectWillChange.sink(receiveValue: { self.objectWillChange.send() })

			// Important: You have to keep the returned value allocated,
			// otherwise the sink subscription gets cancelled
			self.cancellables.append(c)
		})
	}
}

// MARK: - Icon Set API

extension IconSet {
	func isValid() -> Bool {
		return UUID != ""
	}
	
	func lock() {
		isLocked = true
	}
	
	func unlock() {
		isLocked = false
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
		.iconSetFree1,	// Cute Color
		.iconSet1,		// Doodle
		.iconSet2,		// Gradient Line
		.iconSet3,		// Line
		.iconSet4,		// Dotty
//		.iconSet5		//
	]
	
	static let defaultSet: IconSet = .iconSet1
	
	// MARK: - Free icon sets
	
	static let iconSetFree1 = IconSet(
		id: "app.icongeek.iconset.free1",
		title: "Cute Color",
		group: "icon-set-cutecolor",
		UUID: "01832E06-B08F-4935-A916-0A2AD7B81BE5",
		isLocked: false
	)
	
	// MARK: - Icon sets for purchase
	
	static let iconSet1 = IconSet(
		id: "app.icongeek.iconset1",
		title: "Doodle",
		group: "icon-set-doodle",
		UUID: "5A952F19-0ECD-4781-ABF4-9A1AA89BD02F",
		isLocked: true
	)

	static let iconSet2 = IconSet(
		id: "app.icongeek.iconset2",
		title: "Gradient Line",
		group: "icon-set-gradient",
		UUID: "C88F3187-FF2D-4BA8-84C6-B0519A682CED",
		isLocked: true,
		options: [
			"foreground": Color.white,
			"background": Color.black,
			"icon-background": Color.black,
			"tint": Color.purple
		]
	)
	
	static let iconSet3 = IconSet(
		id: "app.icongeek.iconset3",
		title: "Line",
		group: "icon-set-line",
		UUID: "DE6D4810-4BD9-4A09-983B-05DF8EC75893",
		isLocked: true,
		options: [
			"icon-background": Color.white,
			"background": Color.gray
		]
	)
	
	static let iconSet4 = IconSet(
		id: "app.icongeek.iconset4",
		title: "Dotty",
		group: "icon-set-dotty",
		UUID: "E58F53CD-CA0C-424C-BADA-C1CA434D7A9D",
		isLocked: true,
		options: [
			"icon-background": Color.white,
			"background": Color.gray
		]
	)

}
