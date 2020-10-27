//
//  IconGeekModel.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import Foundation
import Alamofire

class AppModel: ObservableObject {
}

// MARK: - IconGeek API

extension AppModel {
	/// N.B. the trailing slash on the URL is important. Without it, the request becomes a redirect and changes from a POST to a GET.
	static let UploadURL = "http://imac.local/ig/upload/"
	
	func addToHomeScreen(_ iconSet: IconSet) -> UploadRequest {
		// 1. Generate the .mobileconfig file
		let mobileConfig = generateMobileConfig(iconSet)
		
		// 2. Upload the mobile config for signing
		let data = Data(mobileConfig.utf8)
		let req = AF.upload(multipartFormData: { (form) in
			form.append(data, withName: "file1")
		}, to: AppModel.UploadURL)
			.responseString { response in
				print("Response string: \(response.value ?? "")")
				// 3. Decode JSON response

				// 4. Post notification
				NotificationCenter.default.post(name: .ReceivedMobileConfigResponse,
												object: nil,
												userInfo: [AppModel.ConfigResponseUUID: UUID(uuidString: "6b9efd8a-def0-6f40-7195-8722b7138ec9")!])
			}
		return req
	}
}

