//
//  FontView.swift
//  IconGeek
//
//  Created by Brainflash on 11/11/2020.
//

import SwiftUI
import FASwiftUI

struct FontView: View {
	@State var selectedIcon: String?
	@State var showingPicker: Bool = false
	
	var body: some View {
		VStack {
			FAText(iconName: selectedIcon ?? "question-square", size: 200)
			Button(action: {
				self.showingPicker = true
			}) {
				Text("Choose icon")
				
				if let icon = selectedIcon {
					Text("Selected: \"\(icon)\"")
				}
			}
		}
		.sheet(isPresented: $showingPicker) {
			FAPicker(showing: self.$showingPicker, selected: self.$selectedIcon)
		}
	}
}
struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        FontView()
    }
}
