//
//  DownloadConfigView.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import SwiftUI

struct DownloadConfigView: View {
	@Environment(\.openURL) var openURL
	
	private var mobileConfigUUID: UUID?
	
	init(_ mobileConfigUUID: UUID) {
		self.mobileConfigUUID = mobileConfigUUID
	}
	
    var body: some View {
		HStack(alignment: .top) {
			VStack(alignment: .center) {
	//			Text("Hello, World! \(mobileConfigUUID!.uuidString)")
		//			.navigationBarBackButtonHidden(true)

				Link("Download icon configuration", destination: URL(string: "\(AppConfig.DownloadURL)\(mobileConfigUUID!).mobileconfig")!)
					.font(.largeTitle)
					.padding()
					.border(Color.black, width: 4)
					.cornerRadius(10)

				let settingsURL = URL(string: UIApplication.openSettingsURLString)!
	//			Button(action: { openURL(settingsURL) }) {
	//				Label("Open Settings", systemImage: "gear")
	//			}
				Link("Install downloaded profile in Settings", destination: settingsURL)
					.font(.title)
					.padding()

			}
		}
    }
}

struct DownloadConfigView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadConfigView(UUID())
    }
}
