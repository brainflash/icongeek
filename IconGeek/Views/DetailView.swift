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
	
	var iconSet: IconSet = IconSet.defaultSet
	
	let pub = NotificationCenter.default
		.publisher(for: .ReceivedMobileConfigResponse)
	@State var mobileConfigUUID: UUID?
	@State var secondViewText = Text("Second View")
	
    var body: some View {
		
		ZStack {
			iconSet.display.backgroundColor.edgesIgnoringSafeArea(.all)
			VStack(alignment: .leading, spacing: 16) {
				HStack(alignment: .top) {
					IconSetView(iconSet: iconSet)
				}

				NavigationLink(destination: DownloadConfigView(mobileConfigUUID ?? UUID()), isActive: $isShowingSecondView) { EmptyView() }
				
				Button(action: addToHomeScreen) {
					Text("Add to home screen")
						.font(.subheadline)
						.bold()
						.padding(.horizontal, 16)
						.padding(.vertical, 8)
						.contentShape(Rectangle())
						.foregroundColor(Color.white)
						.background(Color.black)
						.clipShape(Capsule())
				}
				.accessibility(label: Text("Add to home screen"))
				.padding(.vertical, 8)
				.padding(.horizontal, 16)
			}
			.onReceive(pub) { obj in
				if let userInfo = obj.userInfo, let info = userInfo[AppModel.ConfigResponseUUID] as? UUID {
					self.mobileConfigUUID = info
					self.secondViewText = Text("Second View (\(info.uuidString))")
				}
				isShowingSecondView = true
			}
		}
	}
	
	func addToHomeScreen() {
		NSLog("addToHomeScreen")
		
		model.addToHomeScreen(iconSet)
	}
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
			.environmentObject(AppModel())
    }
}
