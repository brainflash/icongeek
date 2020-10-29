//: A Cocoa based Playground to present user interface
/*
import AppKit
import PlaygroundSupport

let nibFile = NSNib.Name("MyView")
var topLevelObjects : NSArray?

Bundle.main.loadNibNamed(nibFile, owner:nil, topLevelObjects: &topLevelObjects)
let views = (topLevelObjects as! Array<Any>).filter { $0 is NSView }

// Present the view in Playground
PlaygroundPage.current.liveView = views[0] as! NSView
*/

import Foundation

let uuid1 = UUID()

extension String {
	static let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

	static func randomString(_ length: Int) -> String {
	  return String((0..<length).map{ _ in letters.randomElement()! })
	}
}

String.randomString(8)

