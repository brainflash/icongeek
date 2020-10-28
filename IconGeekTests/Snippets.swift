//
//  Snippets.swift
//  IconGeekTests
//
//  Created by Brainflash on 28/10/2020.
//

import Foundation

// Save generated icon PNGs to documents folder
func getDocumentsDirectory() -> URL {
	let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
	return paths[0]
}

func generateMobileConfig(_ iconSet: IconSet) -> String {
//	...
//		... after 					if let imageData = image.pngData() {
		let filename = getDocumentsDirectory().appendingPathComponent("\(icon.name).png")
		try? imageData.write(to: filename)
		NSLog("Saved image to file: \(filename)")
}
