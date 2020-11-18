//
//  PreviewIconsView.swift
//  IconGeek
//
//  Created by Brainflash on 11/11/2020.
//

import SwiftUI

struct PreviewIconsView: View {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	
	@EnvironmentObject var model: AppModel
	@ObservedObject var iconSet: IconSet
	
	init(iconSet: IconSet) {
		self.iconSet = iconSet
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			IconSetView(iconSet: iconSet, iconMode: .preview, viewBackground: $iconSet.viewBackground)

			HStack {
				backButton

				exportLargeButton

				exportSmallButton
			}
		}
		.navigationBarHidden(true)
	}
	
	var exportLargeButton: some View {
		Button(action: { model.exportIcons(iconSet, size: .large) }) {
			Text("Export Large")
//				.font(.headline)
				.font(.body)
				.bold()
//				.padding(.horizontal, 16)
//				.padding(.vertical, 16)
				.contentShape(Capsule())
				.foregroundColor(Color.white)
				.background(Color.black)
		}
//		.accessibility(label: Text("Export Large"))
//		.cornerRadius(20)
//		.overlay(
//			Capsule()
//				.stroke(iconSet.display.tintColor, lineWidth: 6)
//		)
//		.padding(.vertical, 20)
//		.padding(.horizontal, 16)
		.background(Color.clear)
	}
	
	var exportSmallButton: some View {
		Button(action: { model.exportIcons(iconSet, size: .small) }) {
			Text("Export Small")
//				.font(.headline)
				.font(.body)
				.bold()
//				.padding(.horizontal, 16)
//				.padding(.vertical, 16)
				.contentShape(Capsule())
				.foregroundColor(Color.white)
				.background(Color.black)
		}
		.accessibility(label: Text("Export Small"))
//		.cornerRadius(20)
//		.overlay(
//			Capsule()
//				.stroke(iconSet.display.tintColor, lineWidth: 6)
//		)
//		.padding(.vertical, 20)
//		.padding(.horizontal, 16)
		.background(Color.clear)
	}
	
	var backButton: some View {
		Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
			Text("Back")
//				.font(.headline)
				.font(.body)
				.bold()
				.padding(.horizontal, 16)
//				.padding(.vertical, 16)
				.contentShape(Capsule())
				.foregroundColor(Color.white)
				.background(Color.black)
		}
		.accessibility(label: Text("Back"))
//		.cornerRadius(20)
//		.overlay(
//			Capsule()
//				.stroke(iconSet.display.tintColor, lineWidth: 6)
//		)
//		.padding(.vertical, 20)
//		.padding(.horizontal, 16)
		.background(Color.clear)
	}
}

struct PreviewIconsView_Previews: PreviewProvider {
    static var previews: some View {
		let iconSet = IconSet.iconSet5
		PreviewIconsView(iconSet: iconSet)
    }
}
