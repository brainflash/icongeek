//
//  SettingsView.swift
//  IconGeek
//
//  Created by Brainflash on 13/01/2021.
//

import SwiftUI

struct SettingsView: View {
	@Environment(\.presentationMode) var presentation
	
    var body: some View {
		NavigationView {
			Group {
				Text("Settings View")
			}
			.preferredColorScheme(.dark)		// white status bar tint
			.navigationBarItems(trailing:
				Button(action: { self.presentation.wrappedValue.dismiss() }) {
						Text("Done")
							.foregroundColor(.white)
					}
			)
			.navigationBarTitle(Text("Settings"))
		}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
