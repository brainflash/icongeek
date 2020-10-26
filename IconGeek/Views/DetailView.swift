//
//  DetailView.swift
//  IconGeek
//
//  Created by Brainflash on 24/10/2020.
//

import SwiftUI

struct DetailView: View {
	@EnvironmentObject private var model: AppModel
	
	var iconSet: IconSet = IconSet.defaultSet
	
    var body: some View {
		let bgColor: Color = iconSet.options["background"] as? Color ?? Color.appBackground
		
		ZStack {
			bgColor.edgesIgnoringSafeArea(.all)
			VStack(alignment: .leading, spacing: 16) {
				HStack(alignment: .top) {
					IconSetView(iconSet: iconSet)
				}
				
				Button(action: addToHomeScreen) {
					Text("Add to home screen")
						.font(.subheadline)
						.bold()
						.padding(.horizontal, 16)
						.padding(.vertical, 8)
						.contentShape(Rectangle())
						.foregroundColor(Color.white)
						.background(Color.black)
						.clipShape(Capsule())
				}
				.accessibility(label: Text("Add to home screen"))
				.padding(.vertical, 8)
				.padding(.horizontal, 16)
			}
		}
	}
	
	func addToHomeScreen() {
		NSLog("addToHomeScreen")
		
		model.addToHomeScreen(iconSet)
		
	}
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
			.environmentObject(AppModel())
    }
}
