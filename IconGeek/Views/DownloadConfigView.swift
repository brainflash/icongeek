//
//  DownloadConfigView.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import SwiftUI

struct DownloadConfigView: View {
	@Environment(\.openURL) var openURL
	
	@State private var isShowingBrowserView = false
	private var mobileConfigUUID: UUID?
	
	init(_ mobileConfigUUID: UUID) {
		self.mobileConfigUUID = mobileConfigUUID
	}
	
    var body: some View {
		HStack(alignment: .top) {
			VStack(alignment: .center) {
				// Step 1: Download icon configuration
				Button(action: { isShowingBrowserView = true }, label: {
					Text("Download icon configuration")
				})
					.font(.largeTitle)
					.padding()
					.border(Color.black, width: 4)
					.cornerRadius(10)

				// Step 2: Install download profile via Settings
				let settingsURL = URL(string: UIApplication.openSettingsURLString)!
				Link("Install downloaded profile in Settings", destination: settingsURL)
					.font(.title)
					.padding()

				// Step 3: Display post-install view?
				//
				// TODO: 
			}
		}
		.sheet(isPresented: $isShowingBrowserView) {
			let url = URL(string: "\(AppConfig.DownloadURL)?configID=\(mobileConfigUUID!)")!
			SafariBrowserView(url: url)
		}
    }
}

struct DownloadConfigView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadConfigView(UUID())
    }
}
