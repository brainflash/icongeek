//
//  IconGeekModel.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import Foundation
import Alamofire
import Combine

class AppModel: ObservableObject {
	@Published var iconSets = IconSet.all
	var cancellables = [AnyCancellable]()

	init() {
		self.iconSets.forEach({
			let c = $0.objectWillChange.sink(receiveValue: { self.objectWillChange.send() })

			// Important: You have to keep the returned value allocated,
			// otherwise the sink subscription gets cancelled
			self.cancellables.append(c)
		})
	}
}

struct MobileConfigResponse: Codable {
	var status: String
	var error: String?
	var uuid: String?
}

// MARK: - IconGeek API

extension AppModel {

	func addToHomeScreen(_ iconSet: IconSet) -> UploadRequest? {
		// 1. Generate the .mobileconfig file
		let mobileConfig = generateMobileConfig(iconSet)
		
		guard mobileConfig.count > 0 else {
			NotificationCenter.default.post(name: .ReceivedMobileConfigResponse,
											object: nil,
											userInfo: [AppModel.ConfigResponseError: MobileConfigError.mobileConfigEmpty])
			return nil
		}
		
		// 2. Upload the mobile config for signing
		let data = Data(mobileConfig.utf8)
		let req = AF.upload(multipartFormData: { (form) in
			form.append(data, withName: "file1")
		}, to: AppConfig.UploadURL)
			.responseJSON { resp in
				// 3. Check JSON response
				if let value = resp.value {
					let json: Dictionary<String, String> = value as! Dictionary<String, String>
					if json["status"] == "OK" {
						// 4. Post notification
						NotificationCenter.default.post(name: .ReceivedMobileConfigResponse,
														object: nil,
														userInfo: [AppModel.ConfigResponseUUID: UUID(uuidString: json["uuid"]!)!])
					} else {
						NotificationCenter.default.post(name: .ReceivedMobileConfigResponse,
														object: nil,
														userInfo: [AppModel.ConfigResponseError: MobileConfigError.signingError])
					}
				} else {
					NotificationCenter.default.post(name: .ReceivedMobileConfigResponse,
													object: nil,
													userInfo: [AppModel.ConfigResponseError: MobileConfigError.jsonMissing])
				}
			}
		return req
	}
}

