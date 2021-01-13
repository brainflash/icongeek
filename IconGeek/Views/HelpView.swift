//
//  HelpView.swift
//  IconGeek
//
//  Created by Brainflash on 13/01/2021.
//

import SwiftUI

struct HelpView: View {
	@Environment(\.presentationMode) var presentation
	
    var body: some View {
		NavigationView {
			Group {
				WebView(AppConfig.SupportURL)
			}
			.preferredColorScheme(.dark)		// white status bar tint
			.navigationBarItems(trailing:
				Button(action: { self.presentation.wrappedValue.dismiss() }) {
						Image(systemName: "xmark")
							.foregroundColor(.white)
							.padding()
					}
			)
			.navigationBarTitle(Text("Help"), displayMode: .inline)
		}
	}
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
