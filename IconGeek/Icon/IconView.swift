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
	
    var body: some View {
		ZStack {
			Button(action: { icon.toggleSelected() }) {
				image
			}
			
		}
		.background(bgColor)
		.cornerRadius(14)
		.contentShape(Rectangle())
		.frame(maxWidth: 80)
		.overlay(Toggle("Selected", isOn: $icon.selected))
		.toggleStyle(CircleToggleStyle(isLocked: iconSet.isLocked))
		.disabled(iconSet.isLocked)
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
					.frame(width: 80, height: 80)
					.offset(x: 30, y:30)
			} else if configuration.isOn {
				Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
					.font(.system(size: 25, weight: .bold))
					.foregroundColor(Color.black)
					.background(Color.white)
					.accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
					.imageScale(.large)
					.clipShape(Circle())
					.overlay(Circle().stroke(Color.white, lineWidth: 3))
					.frame(width: 80, height: 80)
					.offset(x: 30, y:30)
			}
		}
	}
}

struct IconView_Previews: PreviewProvider {
	
    static var previews: some View {
		IconView(icon: Icon(.appstore, group: IconSet.iconSet1.group), iconSet: IconSet.iconSet1, bgColor: Color.white)
			.frame(width:80, height:80)
    }
}
