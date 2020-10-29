//
//  Icon.swift
//  IconGeek
//
//  Created by Brainflash on 25/10/2020.
//

import SwiftUI

class Icon: ObservableObject, Identifiable {
	var app: AppData
	var group: String
	var labelStyle: LabelStyle = .normal

	enum LabelStyle {
		case normal
		case none
		case lowercase
		case uppercase
	}

	// User variables
	@Published var selected: Bool = false
	
	init(_ app: AppData, group: String) {
		self.app = app
		self.group = group
	}
	
	var name: String {
		switch labelStyle {
			case .normal: return app.name
			case .none: return " "
			case .lowercase: return app.name.lowercased()
			case .uppercase: return app.name.uppercased()
		}
	}
}

extension Icon {
	static func allWithGroup(_ group: String) -> [Icon] {
		var icons: [Icon] = []
		AppList.all.forEach { (app) in
			let icon = Icon(app, group: group)
			let iconExists = icon.imageExists
			if !iconExists {
				NSLog("No icon with asset name \(icon.imageName)")
			}
			if app.isValid() && iconExists {
				icons.append(icon)
			}
		}
		return icons
	}
	
	var imageName: String {
		"\(group)/\(app.name)"
	}
}
