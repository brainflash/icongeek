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
	
	@State private var isShowingSecondView = false
	@State private var isShowingAlert = false
	@State private var showingColorPicker = false
	@State private var errorTitle = ""
	@State private var errorMessage = ""
	
	@ObservedObject var iconSet: IconSet
	
	let pub = NotificationCenter.default
		.publisher(for: .ReceivedMobileConfigResponse)
	@State var mobileConfigUUID: UUID?
	
	init(_ iconSet: IconSet) {
		self.iconSet = iconSet
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.green]
	}
	
	var unlockButton: some View {
		Group {
			if let product = store.product(for: iconSet.id) {
				UnlockButton(product: .init(for: product), purchaseAction: {
					store.purchaseProduct(product)
				})
			} else {
				Text("🔴 Product ID not found for '\(iconSet.title)'")
					.padding()
			}
		}
	}
	
	var addToHomeButton: some View {
		Button(action: addToHomeScreen) {
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
		ZStack {
			VStack(alignment: .leading, spacing: 16) {
				
				HStack(alignment: .top) {
					IconSetView(iconSet: iconSet)
				}

				NavigationLink(destination: DownloadConfigView(mobileConfigUUID ?? UUID()), isActive: $isShowingSecondView) { EmptyView() }
				
				HStack(alignment: .bottom) {
					Button(action: { sheetManager.showPartialSheet({
							print("Sheet dismissed")
						
						}) {
							OptionsView(iconSet: iconSet,
										showLabels: $iconSet.showLabels,
										iconsBackground: $iconSet.iconsBackground,
										onlySelected: $iconSet.onlySelected)
							}
					}, label: {
						Text("Options")
					})
					.padding()
					.frame(maxWidth: .infinity)
				}
				
				HStack(alignment: .bottom) {
					
					if !iconSet.isLocked {
						addToHomeButton
//							.disabled(iconSet.selected.isEmpty)
					} else {
						unlockButton
					}
				}
				.alert(isPresented: $isShowingAlert) {
					Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
				}
			}
			.onReceive(pub) { obj in
				if let userInfo = obj.userInfo {
					if let info = userInfo[AppModel.ConfigResponseUUID] as? UUID {
						self.mobileConfigUUID = info
						isShowingSecondView = true
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
		.addPartialSheet(style: PartialSheetStyle.optionsViewStyle(colorScheme))
		.navigationTitle("Select your icons")
	}

	func addToHomeScreen() {
		NSLog("addToHomeScreen")
		
		guard !iconSet.selected.isEmpty else {
			errorTitle = "No icons selected"
			errorMessage = "Please select at least one icon. Tap on the icon image to toggle its selection"
			isShowingAlert = true
			return
		}
		
		// TODO: - display a spinner alert here
		model.addToHomeScreen(iconSet)
	}
}

// MARK: - Previews
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		DetailView(IconSet.iconSet1)
			.environmentObject(AppModel())
    }
}
