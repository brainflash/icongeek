//
//  AppConfig.swift
//  IconGeek
//
//  Created by Brainflash on 27/10/2020.
//

import Foundation

struct AppConfig {
//	static let serverURL = "https://mobula.uk/apis/icongeek"
//	static let uploadPath = "\(serverURL)/upload/"
//	static let downloadPath = "\(serverURL)/download/"

	static let serverURL = "https://icongeek.app/api"
	static let uploadPath = "\(serverURL)/ul/"
	static let downloadPath = "\(serverURL)/dl/"
	#warning("*** Using live server ***")

//	static let serverURL = "http://imac.local/ig"
//	static let uploadPath = "\(serverURL)/upload/"
//	static let downloadPath = "\(serverURL)/download/"
//	#warning("Local server URL defined")
	
	/// N.B. the trailing slash on the uploadURL is important. Without it, the request becomes a redirect and changes from a POST to a GET.
	static var UploadURL: String {
		uploadPath
	}
	
	static var DownloadURL: String {
		downloadPath
	}
}
