//
//  DownloadConfigView.swift
//  IconGeek
//
//  Created by Brainflash on 26/10/2020.
//

import SwiftUI

struct DownloadConfigView: View {
	private var mobileConfigUUID: UUID?
	
	init(_ mobileConfigUUID: UUID) {
		self.mobileConfigUUID = mobileConfigUUID
	}
	
    var body: some View {
        Text("Hello, World! \(mobileConfigUUID!.uuidString)")
//			.navigationBarBackButtonHidden(true)
		
		Link("Download icon configuration", destination: URL(string: "http://imac.local/ig/download/\(mobileConfigUUID!).mobileconfig")!)
			.font(.largeTitle)
			.foregroundColor(.black)
    }
}

struct DownloadConfigView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadConfigView(UUID())
    }
}
