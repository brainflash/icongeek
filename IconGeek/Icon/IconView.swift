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
	@State var mode: Mode
	
	enum Mode {
		case selecting
		case editing
		case preview
	}
	
	// iconSize returns larger size when selecting. When editing the size should match the home screen icon size,
	// just so the user gets an accurate representation of their chosen icons
	var iconSize: CGFloat {
		switch mode {
		case .selecting:	return 72.0
		case .editing: 		return 60.0
		case .preview: 		return 60.0
		}
	}
	
    var body: some View {
		ZStack {
			VStack {
				Button(action: {
					switch mode {
					case .selecting:
						icon.toggleSelected()
					case .editing:
						icon.toggleEditing()
					case .preview:
						break
					}
				}) {
					image
				}
				.background(icon.background)
				.contentShape(Rectangle())
				.cornerRadius(14)
				.clipped()
				.frame(width: iconSize, height: iconSize)
				.overlay(Group {
					if mode == .selecting {
						Toggle("Selected", isOn: $icon.selected)
					}
				})
				.toggleStyle(CircleToggleStyle(isLocked: iconSet.isLocked, iconSize: iconSize))
				.disabled(iconSet.isLocked)
				.padding(8)

				if mode != .preview {
					Text(icon.name)
						.font(.caption)
						.foregroundColor(iconSet.display.foregroundColor)
						.bold()
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
				}
			}
			
			if mode == .editing && icon.editing {
				Rectangle()
					.fill(Color.clear)
					.border(Color.red, width: 2)
					.padding(2)
			}
		}
		.padding(6)
	}
	
	var image: some View {
		GeometryReader { geo in
			let renderingMode: Image.TemplateRenderingMode = icon.tint != nil ? .template : .original
			
			icon.image
				.resizable()
				.renderingMode(renderingMode)
				.foregroundColor(icon.tint ?? nil)
				.aspectRatio(contentMode: .fill)
				.frame(width: geo.size.width, height: geo.size.height)
				.scaleEffect(icon.scale)
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
		IconView(icon: Icon(.appstore, group: IconSet.iconSet1.group, background: .clear), iconSet: IconSet.iconSet1, mode: .editing)
			.frame(width:100, height:120)
			.background(Color.yellow)
    }
}
