//
//  ContentView.swift
//  IconGeek
//
//  Created by Brainflash on 23/10/2020.
//

import SwiftUI

struct ContentView: View {
	@State var iconSetActive: Bool = true
	
	var iconSets = IconSet.all
	
    var body: some View {
		NavigationView {
			List {
				ForEach(iconSets) { iconSet in
					NavigationLink(
						destination: DetailView(iconSet)) {
						TableRow(title: iconSet.title)
					}
				}
			}
			.navigationTitle("Choose an icon set")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TableRow: View {
	let title: String
	
	var body: some View {
		HStack {
			IconSetThumb()
			IconSetNameView(title: title)
		}
	}
}
