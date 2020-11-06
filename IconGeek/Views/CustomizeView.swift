//
//  CustomizeView.swift
//  IconGeek
//
//  Created by Brainflash on 03/11/2020.
//

import SwiftUI
import PartialSheet

struct CustomizeView: View {
	@Environment(\.colorScheme) var colorScheme
	@EnvironmentObject private var model: AppModel
	@EnvironmentObject private var sheetManager: PartialSheetManager

	@ObservedObject var iconSet: IconSet
	
	@State private var isHelpPresented = false
	@State private var isShowingDownloadConfig = false
	@State private var isShowingAlert = false

	@State private var helpText: String = "Select any icons that you wish to customize by tapping on them.\n\nTap the 'Add to home screen' button when ready."
	@State private var errorTitle = ""
	@State private var errorMessage = ""

	@State var showLabels = true
	@State var bgColor = Color.white
	
	let pub = NotificationCenter.default
		.publisher(for: .ReceivedMobileConfigResponse)
	@State var mobileConfigUUID: UUID?

	
	init(_ iconSet: IconSet) {
		self.iconSet = iconSet
	}
	
	var helpButton: some View {
		Button(action: { self.isHelpPresented = true }) {
			HStack {
				Image(systemName: "questionmark.circle")
					.imageScale(.large)
			}
			.frame(width: 30, height: 30)
		}
		.partialSheet(isPresented: $isHelpPresented) {
			HelpView(helpText: helpText, isPresented: $isHelpPresented)
				.padding()
				.frame(height: 200)
		}
	}
	
	var addToHomeButton: some View {
		Button(action: { addToHomeScreen() }) {
			Text("Add to home screen")
				.font(.headline)
				.bold()
				.padding(.horizontal, 16)
				.padding(.vertical, 16)
				.contentShape(Capsule())
				.foregroundColor(Color.white)
				.background(Color.black)
		}
		.accessibility(label: Text("Add to Home Screen"))
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
			VStack(alignment: .leading, spacing: 16) {
				NavigationLink(destination: DownloadConfigView(mobileConfigUUID ?? UUID()), isActive: $isShowingDownloadConfig) { EmptyView() }
				
				let selectedIcons = IconSet(iconSet: iconSet, icons: iconSet.selected)
				IconSetView(iconSet: selectedIcons, iconMode: .editing)

				HStack(alignment: .bottom) {
					VStack {
						// TODO: need to select the first icon in iconset
						
//						let editing = iconSet.editing
//						if editing.count > 0 {
							OptionsView(iconSet: iconSet,
										showLabels: $showLabels,
										iconsBackground: $iconSet.iconsBackground,
										iconsTint: $iconSet.iconsTint,
										iconsSize: $iconSet.iconsSize)
//						}

						addToHomeButton
					}
				}
			}
		.navigationTitle("Customize your icons").font(.subheadline)
		.navigationBarItems(trailing: HStack { helpButton })
		.alert(isPresented: $isShowingAlert) {
			Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
		}
		.onDisappear() {
			print("CustomizeView onDisappear")
			iconSet.clearEditing()
		}
		.onReceive(pub) { obj in
			if let userInfo = obj.userInfo {
				if let info = userInfo[AppModel.ConfigResponseUUID] as? UUID {
					self.mobileConfigUUID = info
					isShowingDownloadConfig = true
				} else if let err = userInfo[AppModel.ConfigResponseError] as? MobileConfigError {
					errorTitle = "Error message"
					switch err {
					case .jsonMissing:
						errorMessage = "There was an error in the server response\n\n(Code: 0x01 JSON missing)\n\nPlease try again later."
					case .signingError:
						errorMessage = "There was an error in the server response\n\n(Code: 0x02 signing error)\n\nPlease try again later."
					case .mobileConfigEmpty:
						errorMessage = "There was an error generating the icon set\n\n(Code: 0x03 config empty)"
					}
					isShowingAlert = true
				}
			}
		}
    }
	
	func addToHomeScreen() {
		NSLog("addToHomeScreen")
		
		// TODO: - display a spinner alert here
		model.addToHomeScreen(iconSet)
	}
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView(IconSet.iconSet1)
    }
}
