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
		// Make sure all IconSets have a unique iconSetUUID
		var existingIDs: [String:IconSet] = [:]
		IconSet.all.forEach { iconSet in
			let existing: IconSet? = existingIDs[iconSet.UUID]
			XCTAssert(existing == nil, "🔴 UUID exists already (\(existing!.title) / \(iconSet.title) - \(existing!.UUID))")
			existingIDs[iconSet.UUID] = iconSet
		}
	}
	
	func testIconSetIconsExist() throws {
		// Test to see if all icons exist in each IconSet
		var totalIconsMissing = 0

		let expectedMissing: [String : Int] = [
			"Cute Color" : 7,
			"Doodle" : 10
		]
		var actualMissing = [String : Int]()
		
		IconSet.all.forEach { iconSet in
			print("Testing icon set '\(iconSet.title)'")

			var iconsMissing = 0
			let icons = Icon.testAllWithGroup(iconSet.group)
			icons.forEach { icon in
				if icon.imageExists == false {
					print("\t🟡 Icon missing: '\(icon.imageName)'")
					iconsMissing += 1
				}
			}
			actualMissing[iconSet.title] = iconsMissing
			totalIconsMissing += iconsMissing
			print("\t🔴 \(iconsMissing) icons missing")
		}
		
		// Test will always fail due to all of the sets having some icons/apps unavailable.
		// The sets may be updated over time to be complete or have substitutes added,
		// however this is more of an 'informational'/'warning' test rather than an outright pass/fail test.
		//
		// A test could be made for the expected number of missing icons in each set once the sets are finalised.
		// (as has been done now, see below)
		//
		actualMissing.forEach { dict in
			if let expected = expectedMissing[dict.key] {
				let actual = actualMissing[dict.key]!
				
				// TODO: Add a new macro 'XCTFailIf'
				//
				// XCTFail: Test keeps running and failures are counted
				// XCTAssert: Test stops on first failure
				//
				// Proposed XCTFailIf will keep test running and only fail test if test condition is not met.
				//
				if (actual != expected) { XCTFail("\n\t🔴 Actual missing icons different to expected (\(actual) vs \(expected))") }
				// XCTAssert(actual == expected, "\n\t🔴 Actual missing icons different to expected (\(actual) vs \(expected))")
			} else {
				XCTFail("\n\t🔴 Test code error: no expected value for key '\(dict.key)'\n")
			}
		}
		
//		XCTAssert(totalIconsMissing == 0, "\n\t🔴 \(totalIconsMissing)' icons missing")
	}
	
}

// Special test extension method, this is a modification of allWithGroup but adds missing icons
extension Icon {
	static func testAllWithGroup(_ group: String) -> [Icon] {
		var icons: [Icon] = []
		AppList.all.forEach { (app) in
			let icon = Icon(app, group: group)
			if app.isValid() {
				icons.append(icon)
			}
		}
		return icons
	}
}
