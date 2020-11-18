//
//  Icon.swift
//  IconGeek
//
//  Created by Brainflash on 25/10/2020.
//

import SwiftUI
import Combine

class Icon: ObservableObject, Identifiable {
	// User variables
	// TODO: default values for these two should be false
//	@Published var selected: Bool = false
//	@Published var editing: Bool = false
	@Published var selected: Bool = true
	@Published var editing: Bool = true
	@Published var labelStyle: LabelStyle = .normal
	@Published var hasShadow: Bool = false
	@Published var hasGlow: Bool = false
	@Published var shadow: Color = .black
	@Published var background: Color = .white
	@Published var tint: Color? = nil
	@Published var size: Double = 1.0
	var cancellables = Set<AnyCancellable>()
	
	var app: AppData
	var group: String

	enum LabelStyle {
		case normal
		case none
		case lowercase
		case uppercase
	}

	init(_ app: AppData, group: String, background: Color, tint: Color? = nil) {
		self.app = app
		self.group = group
		self.background = background
		self.tint = tint
		
		$background
			.sink(receiveValue: self.backgroundChanged(value:))
			.store(in: &cancellables)
		
//		$labelStyle
//			.sink(receiveValue: self.labelStyleChanged(value:))
//			.store(in: &cancellables)
	}
	
	var name: String {
		switch labelStyle {
			case .normal: return app.name
			case .none: return " "
			case .lowercase: return app.name.lowercased()
			case .uppercase: return app.name.uppercased()
		}
	}
	
	func backgroundChanged(value: Color) {
//		print ("Color changed")
		
//		self.background = value
	}

//	func labelStyleChanged(value: LabelStyle) {
//		print("label style changed")
//
//		self.displayName = self.name
//	}
}

// MARK: - Icon API

extension Icon {
	static func allWithGroup(_ group: String, background: Color, scale: Double, iconList: [String]?) -> [Icon] {
		var icons: [Icon] = []
		
		if let iconList = iconList {
			iconList.forEach { iconName in
				let app = AppData(id: iconName, name: iconName, targetAppID: "app.icongeek")
				let icon = Icon(app, group: group, background: background)
				icon.size = scale
				icons.append(icon)
			}
		} else {
			AppList.all.forEach { (app) in
				let icon = Icon(app, group: group, background: background)
				icon.size = scale
				// TODO: temporarily adding all icons (Font Awesome)
	//			let iconExists = icon.imageExists
				let iconExists = true
				// Added a unit test: IconSetTest.testIconSetIconsExist which outputs the missing icon names to the console
	//			if !iconExists {
	//				print("No icon with asset name \(icon.imageName)")
	//			}
				if app.isValid() && iconExists {
					icons.append(icon)
				}
			}
		}
		return icons
	}
	
	var imageName: String {
		"\(group)/\(app.name)"
	}
	
	func toggleSelected() {
		selected.toggle()
	}
	
	func toggleEditing() {
		editing.toggle()
	}
	
	var scale: CGFloat {
		CGFloat(size)
	}
}
