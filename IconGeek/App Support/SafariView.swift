//
//  SafariView.swift
//  IconGeek
//
//  Created by Brainflash on 05/11/2020.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
	typealias UIViewControllerType = SFSafariViewController
	
	var url: URL?
	
	func makeCoordinator() -> SafariViewCoordinator {
		SafariViewCoordinator()
	}
	
	func makeUIViewController(context: Context) -> UIViewControllerType {
		let safariView = SFSafariViewController(url: url!)
		safariView.delegate = context.coordinator
		return safariView
	}
	
	func updateUIViewController(_ safariViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<SafariView>) {
	}
}

class SafariViewCoordinator: NSObject, SFSafariViewControllerDelegate {
	
}

#if DEBUG
struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
		SafariView(url: URL(string: "https://www.apple.com/uk")!)
    }
}
#endif // DEBUG
