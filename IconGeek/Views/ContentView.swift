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
					NavigationLink(destination: DetailView(iconSet)) {
						TableRow(iconSet: iconSet)
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
	@Environment(\.colorScheme) var colorScheme
	
	let iconSet: IconSet
	
	var body: some View {
		HStack {
			if iconSet.isLocked {
				IconSetThumb()
					.overlay(
						Image(systemName: "lock.circle")
							.font(.system(size: 20))
							.foregroundColor(colorScheme == .dark ? Color.white : Color.black)
							.background(colorScheme == .dark ? Color.black : Color.white)
							.imageScale(.large)
							.clipShape(Circle())
							.frame(width: 100, height: 100)
							.offset(x: 20, y:20)
					)
			} else {
				IconSetThumb()
			}
			IconSetNameView(title: iconSet.title)
		}
	}
}
