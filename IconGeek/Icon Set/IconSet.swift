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
	@Published var labelStyle = Icon.LabelStyle.normal
	@Published var showLabels = true
	@Published var hasShadow = false
	@Published var hasGlow = false
	@Published var multiSelect = true

	/// The user-chosen colour for the preview background
	@Published var viewBackground: Color = Color.appBackground
	/// The user-chosen colour that will be applied to the icon background
	@Published var iconsBackground: Color = .white
	/// The user-chosen colour that will be applied to the icon image/foreground
	@Published var iconsTint: Color = .black

	/// The user-chosen scale of the icon
	// TODO: temporarily changed default value
//	@Published var iconsSize: Double = 1.0
	@Published var iconsSize: Double = 0.8

	var cancellables = [AnyCancellable]()
	
	var id: String
	var title: String
	var group: String
	var UUID: String
	
	var background: String = "default"
	
	var options: Dictionary<String, Any>
	
	var iconList: [String]
	
	/// Resources are used to translate app names into resource names so that the desired icon is shown
	/// e.g. using the Font Awesome fonts: "App Store" (app name) => "app-store" (font name)
	var resources: Dictionary<String, Any>
	
	struct IconSetOptions {
		var foregroundColor: Color = Color.appForeground
		var backgroundColor: Color = Color.appBackground
		var iconBackground: Color = Color.iconBackground
		var tintColor: Color = Color.white
		var supportsTint: Bool = true
		// The amount to scale the icons in the set so that they fit properly at the default scale in Customize View.
		// (Some icon sets are too big/small at 1.0 scale so need this factor to be adjusted accordingly)
		var scaleFactor: Double = 1.0
	}
	var display = IconSetOptions()

//	convenience init(iconSet: IconSet, icons: [Icon]) {
//		self.init(id: iconSet.id, title: iconSet.title, group: iconSet.group, UUID: iconSet.UUID, isLocked: iconSet.isLocked, options: iconSet.options, icons: icons)

	init(iconSet: IconSet, icons: [Icon]) {
		self.id = iconSet.id
		self.title = iconSet.title
		self.group = iconSet.group
		self.UUID = iconSet.UUID
		self.isLocked = iconSet.isLocked
		self.options = iconSet.options
		self.resources = iconSet.resources
		self.iconList = iconSet.iconList
		
		self.display.foregroundColor = iconSet.options["foreground"] as? Color ?? Color.appForeground
		self.display.backgroundColor = iconSet.options["background"] as? Color ?? Color.appBackground
		self.display.iconBackground = iconSet.options["icon-background"] as? Color ?? Color.iconBackground
		self.display.tintColor = iconSet.options["tint"] as? Color ?? Color.appTint
		self.display.supportsTint = iconSet.options["supportsTint"] as? Bool ?? true
		self.display.scaleFactor = iconSet.options["scale-factor"] as? Double ?? 1.0
		self.icons = icons
		self.icons.forEach({
			let c = $0.objectWillChange.sink(receiveValue: { self.objectWillChange.send() })

			// Important: You have to keep the returned value allocated,
			// otherwise the sink subscription gets cancelled
			self.cancellables.append(c)
		})

//		let observables = icons.map { $0.objectWillChange }
//		
//		Publishers.MergeMany(observables)
//			.sink(receiveValue: self.objectWillChange.send)
//			.store(in: &cancellables)
	}
	
	init(id: String, title: String, group: String, UUID: String, isLocked: Bool,
		 options: Dictionary<String, Any>? = nil,
		 iconList: [String]? = nil,
		 resources: Dictionary<String, Any>? = nil) {
		self.id = id
		self.title = title
		self.group = group
		self.UUID = UUID
		self.isLocked = isLocked
		self.options = options ?? [:]
		self.iconList = iconList ?? []
		self.resources = resources ?? [:]

		self.display.foregroundColor = self.options["foreground"] as? Color ?? Color.appForeground
		self.display.backgroundColor = self.options["background"] as? Color ?? Color.appBackground
		self.display.iconBackground = self.options["icon-background"] as? Color ?? Color.iconBackground
		self.display.scaleFactor = self.options["scale-factor"] as? Double ?? 1.0
		self.display.tintColor = self.options["tint"] as? Color ?? Color.appTint
		self.display.supportsTint = self.options["supportsTint"] as? Bool ?? true
		self.icons = Icon.allWithGroup(group, background: self.display.iconBackground, scale: self.display.scaleFactor, iconList: iconList)
		self.icons.forEach({
			let c = $0.objectWillChange.sink(receiveValue: { self.objectWillChange.send() })

			// Important: You have to keep the returned value allocated,
			// otherwise the sink subscription gets cancelled
			self.cancellables.append(c)
		})

		$iconsBackground
			.sink(receiveValue: self.iconsBackgroundChanged(value:))
			.store(in: &cancellables)
		
		$iconsTint
			.sink(receiveValue: self.iconsTintChanged(value:))
			.store(in: &cancellables)
		
		$iconsSize
			.sink(receiveValue: self.iconsSizeChanged(value:))
			.store(in: &cancellables)
		
		$icons
			.sink(receiveValue: self.iconChanged(value:))
			.store(in: &cancellables)

//		let observables = icons.map { $0.objectWillChange }
//
//		Publishers.MergeMany(observables)
//			.sink(receiveValue: self.objectWillChange.send)
//			.store(in: &cancellables)
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
	
	func resourceName(for key: String) -> String? {
		return self.resources[key] as? String ?? nil
	}
	
	func labelStyle(_ style: Icon.LabelStyle) {
		icons.forEach { icon in
			icon.labelStyle = style
		}
	}
	
	func iconsBackgroundChanged(value: Color) {
		let editing = icons.filter { $0.editing }
		editing.forEach { icon in
			icon.background = value
		}
	}
	
	func iconsTintChanged(value: Color) {
		let editing = icons.filter { $0.editing }
		editing.forEach { icon in
			icon.tint = value
		}
	}
	
	func iconsSizeChanged(value: Double) {
		let editing = icons.filter { $0.editing }
		editing.forEach { icon in
			icon.size = value
		}
	}
	
	func iconChanged(value: [Icon]) {
		print("icon changed")
	}

	func toggleLabels() {
		self.showLabels.toggle()
		self.editing.forEach { icon in
			icon.labelStyle = showLabels ? .normal : .none
		}
	}
	
	func toggleShadow() {
		self.hasShadow.toggle()
		self.editing.forEach { icon in
			icon.hasShadow = hasShadow
		}
	}
	
	func toggleGlow() {
		self.hasGlow.toggle()
		self.editing.forEach { icon in
			icon.hasGlow = hasGlow
		}
	}
	
}

// MARK: - selection and editing flags
extension IconSet {

	/// Multi-select edit mode
	func editMultiSelect(multi: Bool) {
		if multi == false {
			let first = self.editing.first
			self.editSelectAll(editing: false)
			first?.editing = true
		}
	}

	/// Set selected flag of all icons
	func selectAll(selected: Bool) {
		icons.forEach { icon in
			icon.selected = selected
		}
	}
	
	func invertSelection() {
		icons.forEach { icon in
			icon.selected.toggle()
		}
	}

	/// Set editing flag of all selected icons
	func editSelectAll(editing: Bool) {
		selected.forEach { icon in
			icon.editing = editing
		}
	}
	
	func editInvertSelection() {
		selected.forEach { icon in
			icon.editing.toggle()
		}
	}
	
	/// Returns an array of Icons that are selected
	var selected: [Icon] {
		icons.filter { icon in
			icon.selected
		}
	}
	
	/// Returns an array of Icons that are editing and selected
	var editing: [Icon] {
		selected.filter { $0.editing }
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
		.iconSet5,		// Font Awesome
		.iconSet6		// Icons8 iOS
	]
	
	static let bigIconList: [String] = [
		"1password",
		   "9gag",
		   "Airbnb",
		   "Airdrop",
		   "Amazon Music",
		   "Amazon",
		   "Among Us",
		   "App Store",
		   "Apple Arcade",
		   "Apple",
		   "Audible",
		   "Automatic",
		   "Bitcoin",
		   "Bookmark",
		   "Brave",
		   "Calculator",
		   "Camera",
		   "Cash App",
		   "Checklist",
		   "Chrome",
		   "Clock",
		   "Contacts",
		   "Credit Card",
		   "Digital Clock",
		   "Discord",
		   "Dribbble",
		   "Dropbox",
		   "Duckduckgo",
		   "Duolingo",
		   "Ethereum",
		   "Evernote",
		   "Facebook",
		   "Facetime",
		   "Find My",
		   "Firefox",
		   "Gmail",
		   "Google Drive",
		   "Google Earth",
		   "Google Maps",
		   "Google Photos",
		   "Health",
		   "Heart",
		   "Houseparty",
		   "Html 5",
		   "iCloud",
		   "Instagram",
		   "Jetpack Joyride",
		   "Lastfm",
		   "Linkedin",
		   "Maps",
		   "Medium",
		   "Messages",
		   "Messenger",
		   "Music",
		   "Napster",
		   "Netflix",
		   "News",
		   "Notes",
		   "Paypal",
		   "Phone",
		   "Photos",
		   "Pinterest",
		   "Playstation",
		   "Plus",
		   "QR Code",
		   "Reddit",
		   "Safari",
		   "Sand Timer",
		   "Services",
		   "Settings 2",
		   "Settings",
		   "Shopify",
		   "Shortcuts",
		   "Siri",
		   "Skype",
		   "Slack",
		   "Smart Watch",
		   "Snapchat",
		   "Soundcloud",
		   "Spotify",
		   "Steam",
		   "Stellar",
		   "Stocks",
		   "Stumbleupon",
		   "Telegram",
		   "TikTok",
		   "Tinder",
		   "Tumblr",
		   "Twitch",
		   "Twitter",
		   "Unreal",
		   "VK",
		   "Venmo",
		   "Vimeo",
		   "Vsco",
		   "Weather",
		   "WhatsApp",
		   "Wordpress",
		   "Xbox",
		   "YouTube",
		   "Zoom",
	   ]
	
	static let defaultSet: IconSet = .iconSet1
	
	// MARK: - Free icon sets
	
	static let iconSetFree1 = IconSet(
		id: "app.icongeek.iconset.free1",
		title: "Cute Color",
		group: "icon-set-cutecolor",
		UUID: "01832E06-B08F-4935-A916-0A2AD7B81BE5",
		isLocked: false,
		options: [
			"supportsTint" : false
		]
	)
	
	// MARK: - Icon sets for purchase
	
	static let iconSet1 = IconSet(
		id: "app.icongeek.iconset1",
		title: "Icon Geek 1",
		group: "icon-set-geek-1",
		UUID: "5A952F19-0ECD-4781-ABF4-9A1AA89BD02F",
		isLocked: false
//		iconList: bigIconList
	)

	static let iconSet2 = IconSet(
		id: "app.icongeek.iconset2",
		title: "Icon Geek 2",
		group: "icon-set-geek-2",
		UUID: "C88F3187-FF2D-4BA8-84C6-B0519A682CED",
//		isLocked: true,
		isLocked: false,
		options: [
			"foreground": Color.white,
			"background": Color.black,
			"icon-background": Color.black,
			"tint": Color.purple
		]
//		iconList: bigIconList
	)
	
	static let iconSet3 = IconSet(
		id: "app.icongeek.iconset3",
		title: "Icon Geek 3",
		group: "icon-set-geek-3",
		UUID: "DE6D4810-4BD9-4A09-983B-05DF8EC75893",
//		isLocked: true,
		isLocked: false,
		options: [
			"icon-background": Color.white,
			"background": Color.gray
		]
//		iconList: bigIconList
	)
	
	static let iconSet4 = IconSet(
		id: "app.icongeek.iconset4",
		title: "Icon Geek 4",
		group: "icon-set-geek-4",
		UUID: "E58F53CD-CA0C-424C-BADA-C1CA434D7A9D",
		// TODO: set to locked
//		isLocked: true,
		isLocked: false,
		options: [
			"icon-background": Color.white,
			"background": Color.gray,
			"scale-factor": 0.9
		]
	)

	static let iconSet5 = IconSet(
		id: "app.icongeek.iconset5",
		title: "Icon Geek 5",
		group: "icon-set-geek-5",
		UUID: "CCEA19B5-BC1A-4629-AAF0-E113B52385FB",
		// TODO: set to locked
//		isLocked: true,
		isLocked: false,
		options: [
			"icon-background": Color.white,
			"background": Color.gray,
			"scale-factor": 0.9
		]
	)
	
	/*
	static let iconSet5 = IconSet(
		id: "app.icongeek.iconset5",
		title: "Font Awesome",
		group: "icon-set-fontawesome",
		UUID: "CCEA19B5-BC1A-4629-AAF0-E113B52385FB",
		// TODO: set to locked
//		isLocked: true,
		isLocked: false,
		options: [
			"icon-background": Color.white,
			"background": Color.gray,
			"scale-factor": 0.7
		],
		// These are overrides for Font Awesome names
		resources: [
			"App Store": "app-store",
			"Books": "book-open",
			"Music": "itunes-note",
			"Messenger": "facebook-messenger",
			"Kik": false,
			"Houseparty": false,
		]
	)
	*/
	
	static let iconSet6 = IconSet(
		id: "app.icongeek.iconset6",
		title: "Icons8 - iOS",
		group: "icon-set-icons8-ios",
		UUID: "D7226209-7434-451A-AB5A-290817BE1787",
		// TODO: set to locked
//		isLocked: true,
		isLocked: false,
		options: [
			"icon-background": Color.white,
			"background": Color.gray,
			"scale-factor": 0.5
		],
		iconList: bigIconList,
		// These are overrides for Font Awesome names
		resources: [
			"App Store": "app-store",
			"Books": "book-open",
			"Music": "itunes-note",
			"Messenger": "facebook-messenger",
			"Kik": false,
			"Houseparty": false,
		]
	)

}
