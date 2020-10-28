//
//  Icon+SwiftUI.swift
//  IconGeek
//
//  Created by Brainflash on 25/10/2020.
//

import SwiftUI

// MARK: - SwiftUI

extension Icon {
	
	/// The image for this icon
	var image: Image {
		Image(self.imageName, label: Text(name))
			.renderingMode(.original)
	}
	
	var imageExists: Bool {
		UIImage(named: self.imageName) != nil
	}
}
