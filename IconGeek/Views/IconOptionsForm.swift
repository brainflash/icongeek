//
//  IconOptionsForm.swift
//  IconGeek
//
//  Created by Brainflash on 30/10/2020.
//

import SwiftUI

struct IconOptionsForm: View {
	var body: some View {
//		NavigationView {
		ZStack(alignment: .bottom) {
			Spacer()
			Form {
				Section(header: Text("App data"), footer: Text("None of those action are working yet ;)"), content: {
					Text("Export my data")
					Text("Backup to iCloud")
					Text("Restore from iCloud")
					Text("Reset application data").foregroundColor(.red)
				})
			}
//			.navigationBarTitle(Text("Settings"))
		}
		.frame(maxHeight: UIScreen.main.bounds.height)
		.offset(y: UIScreen.main.bounds.height/2)
	}
}

// MARK: - Previews
struct IconOptionsForm_Previews: PreviewProvider {
    static var previews: some View {
        IconOptionsForm()
    }
}
