//
//  SettingsForm.swift
//  IconGeek
//
//  Created by Brainflash on 30/10/2020.
//

import SwiftUI

struct SettingsForm: View {
    var body: some View {
		NavigationView {
			Form {
				Section(header: Text("App data"), footer: Text("None of those action are working yet ;)"), content: {
					Text("Export my data")
					Text("Backup to iCloud")
					Text("Restore from iCloud")
					Text("Reset application data").foregroundColor(.red)
				})
			}
			.navigationBarTitle(Text("Settings"))
		}
    }
}

// MARK: - Previews
struct SettingsForm_Previews: PreviewProvider {
    static var previews: some View {
        SettingsForm()
    }
}
