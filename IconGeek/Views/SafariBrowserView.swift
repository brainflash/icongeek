//
//  SafariBrowserView.swift
//  IconGeek
//
//  Created by Brainflash on 05/11/2020.
//

import SwiftUI

struct SafariBrowserView: View {
	let url: URL
	
    var body: some View {
		SafariView(url: url)
			.navigationBarHidden(true)
    }
}

struct SafariBrowserView_Previews: PreviewProvider {
    static var previews: some View {
		SafariBrowserView(url: URL(string: "https://www.apple.com/uk")!)
    }
}
