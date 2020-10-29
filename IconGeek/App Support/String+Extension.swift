//
//  String+Extension.swift
//  IconGeek
//
//  Created by Brainflash on 29/10/2020.
//

import Foundation

extension String {
	static let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

	static func randomString(_ length: Int) -> String {
		return String((0..<length).map{ _ in letters.randomElement()! })
	}
}
