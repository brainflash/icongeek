//
//  UIImage+Extension.swift
//  IconGeek
//
//  Created by Brainflash on 28/10/2020.
//

import UIKit

public extension UIImage {
	/// Create a UIImage with solid color background with specified image overlaid
	convenience init?(color: UIColor, image: UIImage, scale: CGFloat?) {
		let rect = CGRect(origin: .zero, size: image.size)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, scale ?? 0.0)
		color.setFill()
		UIRectFill(rect)
		
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		
		UIGraphicsPushContext(context)
		image.draw(in: rect)
		UIGraphicsPopContext()
		
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		guard let cgImage = newImage?.cgImage else { return nil }
		self.init(cgImage: cgImage, scale: scale ?? image.scale, orientation: image.imageOrientation)
	}
}
