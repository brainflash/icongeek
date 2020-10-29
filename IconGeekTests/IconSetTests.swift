//
//  IconSetTests.swift
//  IconGeekTests
//
//  Created by Brainflash on 27/10/2020.
//

import XCTest

// Things still to test:
//
// 1. Make sure selected flag on Icon works
//

class IconSetTests: XCTestCase {

	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testIconSetForProductIDs() throws {
		// 1. Make sure all IconSet IDs match the corresponding product ID in Store (for IAPs)
		var prodIDs = Array(Store.ProductIdentifier.all)
		IconSet.all.forEach { iconSet in
			if iconSet.id.suffix(8).contains(".free") == false {
				XCTAssert(prodIDs.contains(iconSet.id), "🔴 Product with ID '\(iconSet.id)' not found")
				prodIDs.removeAll(where: { $0 == iconSet.id })
			} else {
				NSLog("🟢 Skipping free iconSet (ID: \(iconSet.id))")
			}
		}
		if prodIDs.count > 0 {
			// These product identifiers exist but were not present in the IconSet.all array
			NSLog("🟡 prodIDs not in IconSet.all: \(prodIDs)")
		}
	}
	
	func testIconSetForUniqueIDs() throws {
		// 1. Make sure all IconSets have a unique iconSetUUID
		var existingIDs: [String:IconSet] = [:]
		IconSet.all.forEach { iconSet in
			let existing: IconSet? = existingIDs[iconSet.UUID]
			XCTAssert(existing == nil, "🔴 UUID exists already (\(existing!.title) / \(iconSet.title) - \(existing!.UUID))")
			existingIDs[iconSet.UUID] = iconSet
		}
	}
	
}
