//
//  Icon.swift
//  IconGeek
//
//  Created by Brainflash on 25/10/2020.
//

import Combine

class Icon: ObservableObject, Identifiable {
	// User variables
	@Published var selected: Bool = false
	@Published var labelStyle: LabelStyle = .normal
	var cancellables = Set<AnyCancellable>()
	
	var app: AppData
	var group: String

	enum LabelStyle {
		case normal
		case none
		case lowercase
		case uppercase
	}

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

// MARK: - Icon API

extension Icon {
	static func allWithGroup(_ group: String) -> [Icon] {
		var icons: [Icon] = []
		AppList.all.forEach { (app) in
			let icon = Icon(app, group: group)
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
}
