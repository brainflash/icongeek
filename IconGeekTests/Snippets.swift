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

func partialSheet_add_only_in_root_view {
	// A 'gotcha' for Partial Sheet:
	//
	// The call to '.addPartialSheet' should only be made in the root view as show below (i.e. in ContentView)
	// DON'T add it to any subsequent views as it will cause the size of the sheet to go to the full size
	// Just call .partialSheet from the nested view
	//
	var body: some View {
		NavigationView {
			List {
				...
			}
			.navigationTitle("Choose an icon set")
		}
		.addPartialSheet()
	}
}

func body_partialSheet_options {
	// Shows how to show an Options view in a PartialSheet and get a callback when sheet is dismissed
	// PartialSheet: https://github.com/AndreaMiotto/PartialSheet/
	//
	HStack(alignment: .bottom) {
		Button(action: { sheetManager.showPartialSheet({
				print("Sheet dismissed")
			
			}) {
				OptionsView(iconSet: iconSet,
							showLabels: $iconSet.showLabels,
							iconsBackground: $iconSet.iconsBackground,
							iconsSize: $iconSet.iconsSize,
							selected: $selected)
				}
		}, label: {
			Text("Options")
		})
		.padding()
		.frame(maxWidth: .infinity)
	}
}
