//
//  AppConfig.swift
//  IconGeek
//
//  Created by Brainflash on 27/10/2020.
//

import Foundation

struct AppConfig {
//	static let serverURL = "https://mobula.uk/apis/icongeek"
	
	static let serverURL = "http://imac.local/ig"
	#warning("Local server URL defined")
	
	/// N.B. the trailing slash on the uploadURL is important. Without it, the request becomes a redirect and changes from a POST to a GET.
	static var UploadURL: String {
		"\(serverURL)/upload/"
	}
	
	static var DownloadURL: String {
		"\(serverURL)/download/"
	}
}
