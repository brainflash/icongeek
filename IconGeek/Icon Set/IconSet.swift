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
	var background: String = "default"
	var icons: [Icon]
	var options: Dictionary<String, Any>
	
	init(id: String, title: String, group: String, options: Dictionary<String, Any>?) {
		self.id = id
		self.title = title
		self.group = group
		self.icons = Icon.allWithGroup(group)
		self.options = options ?? [:]
	}
}

// MARK: - Icon Sets

extension IconSet {
	static let all: [IconSet] = [
		.iconSet1,
		.iconSet2,
		.iconSet3
	]
	
	static let defaultSet: IconSet = .iconSet1
	
	static let iconSet1 = IconSet(
		id: "icon-set-1",
		title: "Doodle",
		group: "icon-set-1",
		options: nil
	)
	
	static let iconSet2 = IconSet(
		id: "icon-set-2",
		title: "Cute Color",
		group: "icon-set-2",
		options: nil
	)

	static let iconSet3 = IconSet(
		id: "icon-set-3",
		title: "Gradient Line",
		group: "icon-set-3",
		options: [
			"background": Color.white
		]
	)

}
