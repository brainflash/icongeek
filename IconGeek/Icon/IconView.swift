//
//  IconView.swift
//  IconGeek
//
//  Created by Brainflash on 24/10/2020.
//

import SwiftUI

struct IconView: View {
	@Environment(\.colorScheme) var colorScheme
	
	@ObservedObject var icon: Icon
	var bgColor: Color
	
    var body: some View {
		ZStack {
			Button(action: { icon.selected.toggle() }) {
				image
			}
			
		}
		.background(bgColor)
		.cornerRadius(14)
		.contentShape(Rectangle())
		.frame(maxWidth: 80)
		.overlay(Toggle("Selected", isOn: $icon.selected))
		.toggleStyle(CircleToggleStyle(colorScheme: colorScheme))
	}
	
	var image: some View {
		GeometryReader { geo in
			icon.image
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: geo.size.width, height: geo.size.height)
		}
		.accessibility(hidden: true)
	}
}

struct CircleToggleStyle: ToggleStyle {
	let colorScheme: ColorScheme
	
	func makeBody(configuration: Configuration) -> some View {
		ZStack {
			configuration.label.hidden()
			if configuration.isOn {
				Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
					.font(.system(size: 25, weight: .bold))
					.foregroundColor(colorScheme == .dark ? Color.white : Color.black)
					.background(colorScheme == .dark ? Color.black : Color.white)
					.accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
					.imageScale(.large)
					.clipShape(Circle())
					.frame(width: 80, height: 80)
					.offset(x: 30, y:30)
			}
		}
	}
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
		IconView(icon: Icon(.blank, group: ""), bgColor: Color.white)
    }
}
