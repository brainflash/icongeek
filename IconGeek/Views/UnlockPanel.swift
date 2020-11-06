//
//  UnlockPanel.swift
//  IconGeek
//
//  Created by Brainflash on 04/11/2020.
//

import SwiftUI

struct UnlockPanel: View {
	@EnvironmentObject private var store: Store
	@ObservedObject var iconSet: IconSet

	var unlockButton: some View {
		Group {
			if let product = store.product(for: iconSet.id) {
				UnlockButton(product: .init(for: product), purchaseAction: {
					store.purchaseProduct(product)
				})
			}
		}
	}
	
    var body: some View {
		
		if let product = store.product(for: iconSet.id) {
			ZStack {
				HStack {
					unlockButton
				}
			}
			.background(VisualEffectBlur())

		} else {
			Text("🔴 Product ID not found for '\(iconSet.title)'")
				.padding()
		}
    }
}

struct UnlockPanel_Previews: PreviewProvider {
    static var previews: some View {
		UnlockPanel(iconSet: IconSet.iconSet1)
    }
}
