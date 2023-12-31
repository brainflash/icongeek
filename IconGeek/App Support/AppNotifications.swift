//
//  AppNotifications.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import Foundation

enum MobileConfigError: Error {
	case jsonMissing
	case signingError
	case mobileConfigEmpty
}

extension Notification.Name {
	
	/// Sent by the App Model when server responds to mobile config signing request
	static let ReceivedMobileConfigResponse = NSNotification.Name("ReceivedMobileCfg")
}

extension AppModel {
	
	/// Dictionary keys used in App Model notification
	static let ConfigResponseUUID = "ConfigResponseUUID"
	static let ConfigResponseError = "ConfigResponseError"
}

