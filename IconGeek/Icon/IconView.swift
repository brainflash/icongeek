//
//  IconView.swift
//  IconGeek
//
//  Created by Brainflash on 24/10/2020.
//

import SwiftUI

struct IconView: View {
	@ObservedObject var icon: Icon
	@ObservedObject var iconSet: IconSet
	var bgColor: Color
	
	let iconSize: CGFloat = 80.0
	
    var body: some View {
		ZStack {
			VStack {
				Button(action: { icon.toggleSelected() }) {
					image
				}
				.background(bgColor)
				.cornerRadius(14)
				.contentShape(Rectangle())
				.frame(width: iconSize, height: iconSize)
				.overlay(Toggle("Selected", isOn: $icon.selected))
				.toggleStyle(CircleToggleStyle(isLocked: iconSet.isLocked, iconSize: iconSize))
				.disabled(iconSet.isLocked)
				
				Text(icon.name)
					.font(.caption)
					.foregroundColor(iconSet.display.foregroundColor)
					.bold()

			}
		}
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
	var isLocked: Bool = false
	let iconSize: CGFloat
	let iconOffset: CGFloat = 30.0
	
	func makeBody(configuration: Configuration) -> some View {
		ZStack {
			configuration.label.hidden()
			if isLocked {
				Image(systemName: "lock.circle")
					.font(.system(size: 25, weight: .bold))
					.foregroundColor(Color.black)
					.background(Color.white)
					.accessibility(label: Text("Locked"))
					.imageScale(.large)
					.clipShape(Circle())
					.frame(width: iconSize, height: iconSize)
					.offset(x: iconOffset, y:iconOffset)
			} else if configuration.isOn {
				Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
					.font(.system(size: 25, weight: .bold))
					.foregroundColor(Color.black)
					.background(Color.white)
					.accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
					.imageScale(.large)
					.clipShape(Circle())
					.overlay(Circle().stroke(Color.white, lineWidth: 3))
					.frame(width: iconSize, height: iconSize)
					.offset(x: iconOffset, y:iconOffset)
			}
		}
	}
}

// MARK: - Previews
struct IconView_Previews: PreviewProvider {
	
    static var previews: some View {
		IconView(icon: Icon(.appstore, group: IconSet.iconSet1.group), iconSet: IconSet.iconSet1, bgColor: Color.white)
			.frame(width:80, height:80)
    }
}
