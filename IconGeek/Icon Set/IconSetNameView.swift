//
//  IconSetNameView.swift
//  IconGeek
//
//  Created by Brainflash on 24/10/2020.
//

import SwiftUI

struct IconSetNameView: View {
	let title: String
	
    var body: some View {
		Text(title)
			.font(.title)
			.fontWeight(.bold)
			.minimumScaleFactor(0.25)
    }
}

struct IconSetNameView_Previews: PreviewProvider {
    static var previews: some View {
		IconSetNameView(title: "Icon Set")
    }
}
