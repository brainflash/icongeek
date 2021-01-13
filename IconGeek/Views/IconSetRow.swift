//
//  IconSetRow.swift
//  IconGeek
//
//  Created by Brainflash on 06/01/2021.
//

import SwiftUI

struct IconSetRow: View {
	@EnvironmentObject private var store: Store
	@ObservedObject var iconSet: IconSet
	@Namespace private var namespace
	
	@Binding var selectedIconSet: IconSet?
	
	var clipShape = RoundedRectangle(cornerRadius: 10, style: .continuous)
	
	var blurView: some View {
		#if os(iOS)
		return VisualEffectBlur(blurStyle: .systemThinMaterialLight)
		#else
		return VisualEffectBlur()
		#endif
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text(iconSet.title)
					.font(.headline)
					.foregroundColor(.black)
					.padding(.leading, 15)
					.padding(.top, 5)

				Spacer()
				
				if let product = store.product(for: iconSet.id) {
					UnlockButton(product: .init(for: product), purchaseAction: {
						store.purchaseProduct(product)
					})
				}
			}
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
//					ForEach(iconSet) { iconSet in
//						Button(action: { select(chargie: chargie) }) {
//							ChargiePreview(pack: pack, chargie: chargie, style: .thumbnail)
//								.frame(width: 96, height: 96)
//								.matchedGeometryEffect(id: chargie.id, in: namespace, isSource: )
//						}
//						ChargiePreview(pack: pack, chargie: chargie, style: .thumbnail)
						
						Button(action: { selectedIconSet = iconSet } ) {
							IconSetThumb()
								.aspectRatio(contentMode: .fill)
								.frame(width: 96, height: 96)
								.clipShape(clipShape)
								.accessibility(hidden: true)
						}
//					}
				}
			}
			.padding(8)
		}
		.listRowBackground(blurView
							.clipped()
							.cornerRadius(20.0)
							.padding(8)
		)
		.padding(.vertical, 8)
	}
}

struct IconSetRow_Previews: PreviewProvider {
	static var selectedIconSet = Binding<IconSet?>.constant(.iconSet1)
	
	static var previews: some View {
		IconSetRow(iconSet: .iconSet1, selectedIconSet: selectedIconSet)
			.environmentObject(Store())
	}
}
