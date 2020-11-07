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
	@Published var selected: Bool = false
	@Published var editing: Bool = false
	@Published var labelStyle: LabelStyle = .normal
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

	init(_ app: AppData, group: String, background: Color) {
		self.app = app
		self.group = group
		self.background = background
		
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
	static func allWithGroup(_ group: String, background: Color, scale: Double) -> [Icon] {
		var icons: [Icon] = []
		AppList.all.forEach { (app) in
			let icon = Icon(app, group: group, background: background)
			icon.size = scale
			let iconExists = icon.imageExists
			// Added a unit test: IconSetTest.testIconSetIconsExist which outputs the missing icon names to the console
//			if !iconExists {
//				print("No icon with asset name \(icon.imageName)")
//			}
			if app.isValid() && iconExists {
				icons.append(icon)
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
