//
//  DetailView.swift
//  IconGeek
//
//  Created by Brainflash on 24/10/2020.
//

import SwiftUI
import PartialSheet

struct DetailView: View {
	@Environment(\.colorScheme) var colorScheme
	@EnvironmentObject private var model: AppModel
	@EnvironmentObject private var store: Store
	@EnvironmentObject private var sheetManager: PartialSheetManager

	@State private var helpText: String = "Select the icons you'd like to add as shortcuts on your Home Screen. \n\nFor the shortcuts to work, the apps you select must already be installed."
	@State private var isHelpPresented = false
	
	@State private var isShowingCustomizeView = false
	@State private var isShowingAlert = false
	@State private var showingColorPicker = false
	@State private var errorTitle = ""
	@State private var errorMessage = ""
	@State var selected: Icon?
	
	@ObservedObject var iconSet: IconSet
	
	init(_ iconSet: IconSet) {
		self.iconSet = iconSet
		
//		$showCustomizeView
//			.sink(receiveValue: self.backgroundChanged(value:))
//			.store(in: &cancellables)
	}
	
	var helpButton: some View {
		Button(action: { self.isHelpPresented = true }) {
			HStack {
				Image(systemName: "questionmark.circle")
					.imageScale(.large)
			}
			.frame(width: 40, height: 40)
		}
		.partialSheet(isPresented: $isHelpPresented) {
			HelpView(helpText: helpText, isPresented: $isHelpPresented)
				.padding()
				.frame(height: 200)
		}
	}
	
	var nextStepButton: some View {
		Button(action: nextStepAction) {
			Text("Next step")
				.font(.headline)
				.bold()
				.padding(.horizontal, 16)
				.padding(.vertical, 16)
				.contentShape(Capsule())
				.foregroundColor(Color.white)
				.background(Color.black)
		}
		.accessibility(label: Text("Next"))
		.cornerRadius(20)
		.overlay(
			Capsule()
				.stroke(iconSet.display.tintColor, lineWidth: 6)
		)
		.padding(.vertical, 20)
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity)
	}

    var body: some View {
		ZStack {
			VStack(alignment: .leading, spacing: 16) {

				NavigationLink(destination: CustomizeView(iconSet), isActive: $isShowingCustomizeView) { EmptyView() }

				HStack(alignment: .top) {
					if iconSet.isLocked {
						ZStack {
							IconSetView(iconSet: iconSet, iconMode: .selecting)
								.overlay(UnlockPanel(iconSet: iconSet), alignment: .bottom)
						}
					} else {
						VStack {
							IconSetView(iconSet: iconSet, iconMode: .selecting)
						
							nextStepButton
						}
						.background(VisualEffectBlur())
					}
				}
//				.overlay(UnlockPanel(iconSet: iconSet), alignment: .bottom)
			}
		}
		.navigationTitle("Select some icons")
		.navigationBarItems(trailing: HStack { helpButton })
		.alert(isPresented: $isShowingAlert) {
			Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
		}
	}

	func nextStepAction() {
		guard !iconSet.selected.isEmpty else {
			errorTitle = "No icons selected"
			errorMessage = "Please select at least one icon. Tap on the icon image to toggle its selection"
			isShowingAlert = true
			return
		}

		isShowingCustomizeView = true
	}

}

// MARK: - Previews
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		DetailView(IconSet.iconSet1)
			.environmentObject(AppModel())
    }
}
