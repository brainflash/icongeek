//
//  AppListTests.swift
//  IconGeekTests
//
//  Created by Brainflash on 28/10/2020.
//

import Foundation
import XCTest

// What to test:
// 1. Make sure all AppData UUIDs are unique
// 2.
//


class AppListTests: XCTestCase {

	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testAppData() throws {
		
		// 1. Test UUIDs in AppData are unique across all apps
		var appIDs: [String:AppData] = [:]
		AppList.all.forEach { app in
			let existing: AppData? = appIDs[app.UUID]
			XCTAssert(existing == nil, "🔴 UUID exists already (\(existing!.name) / \(app.name) - \(existing!.UUID))")
			appIDs[app.UUID] = app
		}
	}
	
}
