//
//  UIImage+Extension.swift
//  IconGeek
//
//  Created by Brainflash on 28/10/2020.
//

import UIKit
import CoreGraphics

public extension UIImage {
	/// Create a UIImage with solid color background with specified image overlaid
	/// Note: the scale of the returned image is fixed at 1.0
	///
	/// - Parameter color: The background colour of the created image.
	/// - Parameter image: An image to draw over the background.
	/// - Parameter scale: The scale at which to draw the image.
	/// - Parameter tint: Tint color to be applied to the supplied image
	/// - Parameter newSize: Created image will be at this new size
	/// - Returns
	/// 	UIImage
	convenience init?(color: UIColor, image: UIImage, scale: CGFloat, tint: UIColor? = nil, newSize: CGSize? = nil) {
		let newImageSize = newSize ?? image.size
		let rect = CGRect(origin: .zero, size: newImageSize)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
		color.setFill()
		UIRectFill(rect)
		
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		
		UIGraphicsPushContext(context)
		let imageSize = scale == 1.0 ? newImageSize : CGSize(width: newImageSize.width * scale,
																  height: newImageSize.height * scale)
		let offset = scale == 1.0 ? .zero : CGPoint(x: (newImageSize.width - imageSize.width) / 2,
													y: (newImageSize.height - imageSize.height) / 2)
		let imageRect = CGRect(origin: offset, size: imageSize)

		var imageToDraw = image
		if let tint = tint {
			if let tintedImage = image.tinted(with: tint) {
				imageToDraw = tintedImage
			}
		}
		
		imageToDraw.draw(in: imageRect)
		UIGraphicsPopContext()
		
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		guard let cgImage = newImage?.cgImage else { return nil }
		self.init(cgImage: cgImage, scale: 1.0, orientation: image.imageOrientation)
	}
	
	/// Tint a UIImage with a colour
	///
	/// - Parameter color: Tint colour.
	/// - Returns
	/// 	UIImage
	func tinted(with color: UIColor) -> UIImage? {
		defer { UIGraphicsEndImageContext() }
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		
		color.set()
		
		self.withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: self.size))
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}
