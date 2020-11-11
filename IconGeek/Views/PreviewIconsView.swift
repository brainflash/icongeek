//
//  PreviewIconsView.swift
//  IconGeek
//
//  Created by Brainflash on 11/11/2020.
//

import SwiftUI

struct PreviewIconsView: View {
	@ObservedObject var iconSet: IconSet
	
	init(iconSet: IconSet) {
		self.iconSet = iconSet
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
//			let selectedIcons = IconSet(iconSet: iconSet, icons: iconSet.selected)
			IconSetView(iconSet: iconSet, iconMode: .preview, viewBackground: $iconSet.viewBackground)
		}
//		.navigationBarHidden(true)
	}
}

struct PreviewIconsView_Previews: PreviewProvider {
    static var previews: some View {
		let iconSet = IconSet.iconSet5
		PreviewIconsView(iconSet: iconSet)
    }
}
