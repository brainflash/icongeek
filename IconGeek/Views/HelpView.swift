//
//  HelpView.swift
//  IconGeek
//
//  Created by Brainflash on 04/11/2020.
//

import SwiftUI
import PartialSheet

struct HelpView: View {
	var helpText: String
	
	@Binding var isPresented: Bool

    var body: some View {
		VStack {
			Group {
				VStack {
					Spacer()
					
					Text(helpText)
						.padding()
						.fixedSize(horizontal: false, vertical: true)
						.multilineTextAlignment(.leading)
						.frame(height:50)
					
					Spacer()

					Button(action: { isPresented = false }) {
						Text("OK")
							.bold()
							.font(.title2)
					}
				}
			}
		}
    }

}

// MARK: - Previews
struct HelpView_Previews: PreviewProvider {
	static var isPresented = Binding<Bool>.constant(true)
	
    static var previews: some View {
        HelpView(helpText: "Here is a bit of help text for a particular view.",
				 isPresented: isPresented)
			.frame(height: 150)
    }
}
