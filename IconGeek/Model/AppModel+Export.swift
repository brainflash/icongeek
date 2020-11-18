//
//  AppModel+Export.swift
//  IconGeek
//
//  Created by Brainflash on 11/11/2020.
//

import Foundation
import UIKit

extension AppModel {
	
	enum ExportSize {
		case small
		case large
	}
	
	func exportIcons(_ iconSet: IconSet, size: ExportSize) -> Bool {
		// TODO: validate iconSet
//		if iconSet.isValid() == false {
//			print("ERROR! -->  iconSet not valid, UUID: '\(iconSet.UUID)'")
//		}

		let selected = iconSet.selected
		guard !selected.isEmpty else { return false }

		// Create folder for icons
		let fm = FileManager.default
		let docURLs = fm.urls(for: .documentDirectory, in: .userDomainMask)
		guard (docURLs.count > 0) else { print("Could not locate document folder"); return false }

		var folderURL: URL?
		do {
			if let documentsFolder = docURLs.first {
//				let contents = try fm.contentsOfDirectory(at: documentsFolder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
				
				let sizeString = size == .small ? "small" : "large"
				folderURL = documentsFolder.appendingPathComponent("\(iconSet.UUID)").appendingPathComponent(sizeString)
				guard folderURL != nil else { print("folderURL is nil"); return false }
				try fm.createDirectory(at: folderURL!, withIntermediateDirectories: true, attributes: nil)
			}
		} catch {
			print ("Error creating folder for icons: \(error)")
			return false
		}
		
		print ("Folder for icons: '\(folderURL!)'")
		
		selected.forEach { icon in
			// Create a UIImage with the background color of the icon set and icon image overlaid
			let tint = icon.tint != nil ? UIColor(icon.tint!) : nil
			if let iconImage = UIImage(named: icon.imageName),
			   // TODO: add a max image size parameter + scale down. Some icons are 256x256 which is more than supported icon size of 144x144
			   let image = UIImage(color: UIColor(icon.background),
								   image: iconImage,
								   scale: icon.scale,
								   tint: tint,
								   newSize: size == ExportSize.small ? CGSize(width: 180, height: 180) : nil) {
				if let imageData = image.pngData(),
				   let imageURL = folderURL?.appendingPathComponent(icon.app.name.appending(".png")){
					// TODO: if file already exists an error is thrown (e.g. if the folder is the same name, change iconSet.UUID above to test)
					do {
						try imageData.write(to: imageURL)
						print ("Saved \(imageURL.lastPathComponent)")
					} catch {
						print ("Error saving icon: \(error)")
					}
				}
			}
		}
		return true
	}
}
