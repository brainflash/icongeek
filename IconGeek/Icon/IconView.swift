//
//  IconView.swift
//  IconGeek
//
//  Created by Brainflash on 24/10/2020.
//

import SwiftUI

struct IconView: View {
	var icon: Icon
	
    var body: some View {
//		let gradient = LinearGradient(gradient: Gradient(colors: [.white, .red, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)

		ZStack {
//			RoundedRectangle(cornerRadius: 20, style: .continuous)
//				.fill(gradient)
			image
		}
		.contentShape(Rectangle())
		.frame(maxWidth: 80)
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
	
	init() {
		self.icon = Icon(.blank, group: "")
	}
	
	init(_ icon: Icon) {
		self.icon = icon
	}
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
    }
}

/*
//		let gradient = LinearGradient(gradient: Gradient(colors: [.white, .red, .black]), startPoint: .top, endPoint: .bottom)
		let gradient = LinearGradient(gradient: Gradient(colors: [.white, .red, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)

		ZStack {
			RoundedRectangle(cornerRadius: 20, style: .continuous)
//				.fill(Color.white)
				.fill(gradient)
			VStack {
				Text("10:31")
					.lineLimit(1)
					.font(.custom("AmericanTypewriter", size: 80.0))
//					.foregroundGradient(gradient)
					.foregroundColor(.black)
//					.opacity(0.5)
//					.blendMode(.overlay)
					.minimumScaleFactor(0.5)
					.padding(.all, 10)
//					.multilineTextAlignment(.trailing)
//					)

//				Text("Widget View 🦄")
			}
		}
*/
