//
//  DetailView.swift
//  IconGeek
//
//  Created by Brainflash on 24/10/2020.
//

import SwiftUI

struct DetailView: View {
	@EnvironmentObject private var model: AppModel
	@State private var isShowingSecondView = false
	@State private var isShowingAlert = false
	@State private var errorMessage = ""
	
	var iconSet: IconSet = IconSet.defaultSet
	
	let pub = NotificationCenter.default
		.publisher(for: .ReceivedMobileConfigResponse)
	@State var mobileConfigUUID: UUID?
	
	init(_ iconSet: IconSet) {
		self.iconSet = iconSet
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.green]
	}
	
    var body: some View {
		ZStack {
			VStack(alignment: .leading, spacing: 16) {
				
				HStack(alignment: .top) {
					IconSetView(iconSet: iconSet)
				}

				NavigationLink(destination: DownloadConfigView(mobileConfigUUID ?? UUID()), isActive: $isShowingSecondView) { EmptyView() }
				
				HStack(alignment: .bottom) {
					Text("Change background color")
						.bold()
						.font(.headline)
				}
				
				HStack(alignment: .bottom) {
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
				.alert(isPresented: $isShowingAlert) {
					Alert(title: Text("Error message"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
				}
			}
			.onReceive(pub) { obj in
				if let userInfo = obj.userInfo {
					if let info = userInfo[AppModel.ConfigResponseUUID] as? UUID {
						self.mobileConfigUUID = info
						isShowingSecondView = true
					} else if let err = userInfo[AppModel.ConfigResponseError] as? MobileConfigError {
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
		.navigationTitle("Select your icons")
	}
	
	func addToHomeScreen() {
		NSLog("addToHomeScreen")
		
		// TODO: - display a spinner alert here
		model.addToHomeScreen(iconSet)
	}
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		DetailView(IconSet.iconSet1)
			.environmentObject(AppModel())
    }
}
