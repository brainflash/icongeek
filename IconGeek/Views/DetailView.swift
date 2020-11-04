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
	
	@State private var isShowingCustomizeView = false
	@State private var isShowingAlert = false
	@State private var showingColorPicker = false
	@State private var errorTitle = ""
	@State private var errorMessage = ""
	@State var selected: Icon?
	
	@ObservedObject var iconSet: IconSet
	
	init(_ iconSet: IconSet) {
		self.iconSet = iconSet
		
//		$showCustomizeView
//			.sink(receiveValue: self.backgroundChanged(value:))
//			.store(in: &cancellables)
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
	
	var nextStepButton: some View {
		Button(action: nextStepAction) {
			Text("Next step")
				.font(.headline)
				.bold()
				.padding(.horizontal, 16)
				.padding(.vertical, 16)
				.contentShape(Capsule())
				.foregroundColor(Color.white)
				.background(Color.black)
		}
		.accessibility(label: Text("Next"))
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
					IconSetView(iconSet: iconSet, iconMode: .selecting)
				}
				
				NavigationLink(destination: CustomizeView(iconSet), isActive: $isShowingCustomizeView) { EmptyView() }
				
				HStack(alignment: .bottom) {
					
					if !iconSet.isLocked {
						nextStepButton
					} else {
						unlockButton
					}
				}
				.alert(isPresented: $isShowingAlert) {
					Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
				}
			}
		}
		.navigationTitle("Select some icons")
	}

	func nextStepAction() {
		guard !iconSet.selected.isEmpty else {
			errorTitle = "No icons selected"
			errorMessage = "Please select at least one icon. Tap on the icon image to toggle its selection"
			isShowingAlert = true
			return
		}

		isShowingCustomizeView = true
	}

}

// MARK: - Previews
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		DetailView(IconSet.iconSet1)
			.environmentObject(AppModel())
    }
}
