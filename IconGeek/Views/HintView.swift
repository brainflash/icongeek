//
//  HintView.swift
//  IconGeek
//
//  Created by Brainflash on 04/11/2020.
//

import SwiftUI
import PartialSheet

struct HintView: View {
	var hintText: String
	
	@Binding var isPresented: Bool

    var body: some View {
		VStack {
			Group {
				VStack {
					Spacer()
					
					Text(hintText)
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
struct HintView_Previews: PreviewProvider {
	static var isPresented = Binding<Bool>.constant(true)
	
    static var previews: some View {
		HintView(hintText: "Here is a bit of help text for a particular view.",
				 isPresented: isPresented)
			.frame(height: 150)
    }
}
