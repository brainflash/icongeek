//
//  ContentView.swift
//  IconGeek
//
//  Created by Brainflash on 23/10/2020.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject private var model: AppModel
	
	@State private var isSettingsPresented = false
	
	var settingsButton: some View {
		Button(action: { self.isSettingsPresented = true }) {
			HStack {
				Image(systemName: "wrench")
					.imageScale(.large)
			}
			.frame(width: 30, height: 30)
		}
	}
	
    var body: some View {
		NavigationView {
			List {
				ForEach(model.iconSets) { iconSet in
					NavigationLink(destination: DetailView(iconSet)) {
						TableRow(iconSet: iconSet)
					}
				}
			}
			.navigationBarItems(trailing:
									HStack {
										settingsButton
									}
			).sheet(isPresented: $isSettingsPresented) {
				// TODO: temporarily showing FontView
//				SettingsForm()
				FontView()
			}
			.navigationTitle("Choose an icon set")
		}
		.addPartialSheet()
	}
}

struct TableRow: View {
	@Environment(\.colorScheme) var colorScheme
	
	@ObservedObject var iconSet: IconSet
	
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

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
