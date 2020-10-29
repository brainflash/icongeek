//
//  UnlockButton.swift
//  IconGeek
//
//  Created by Brainflash on 29/10/2020.
//

import SwiftUI
import StoreKit

struct UnlockButton: View {
	var product: Product
	var purchaseAction: () -> Void
	
	@Environment(\.colorScheme) private var colorScheme
	
	var minWidth: CGFloat {
		return 80
	}
	
	@ViewBuilder var purchaseButton: some View {
		if case let .available(price, locale) = product.availability {
			let displayPrice: String = {
				let formatter = NumberFormatter()
				formatter.locale = locale
				formatter.numberStyle = .currency
				return formatter.string(for: price)!
			}()
			Button(action: purchaseAction) {
				Text(displayPrice)
					.font(.subheadline)
					.bold()
					.foregroundColor(colorScheme == .light ? Color.white : .black)
					.padding(.horizontal, 16)
					.padding(.vertical, 8)
					.frame(minWidth: minWidth)
					.background(colorScheme == .light ? Color.black : .white)
					.clipShape(Capsule())
					.contentShape(Rectangle())
			}
			.buttonStyle(SquishableButtonStyle())
			.accessibility(label: Text("Unlock icon set for \(displayPrice)"))
		}
	}
	
	var bar: some View {
		HStack {
			Button(action: purchaseAction) {
				VStack(alignment: .leading) {
					Text(product.title)
						.foregroundColor(.primary)
						.font(.headline)
						.bold()
					Text(product.description)
						.foregroundColor(.secondary)
						.font(.subheadline)
				}
			}
			
			Spacer()
			
			purchaseButton
		}
		.padding()
		.frame(maxWidth: .infinity)
		.accessibilityElement(children: .combine)
	}
	
	var shape: RoundedRectangle {
		return RoundedRectangle(cornerRadius: 16, style: .continuous)
	}
	
    var body: some View {
		ZStack(alignment: .bottom) {
			bar.background(VisualEffectBlur())
		}
		.clipShape(shape)
		.padding()
		.background(colorScheme == .light ? Color.black : .white)
//		.cornerRadius(10)
		.shadow(color: colorScheme == .light ? Color.white.opacity(0.25) : Color.black.opacity(0.25), radius: 10, x: 0, y: 5)
		.accessibilityElement(children: .contain)
	}
}

extension UnlockButton {
	struct Product {
		var title: String
		var description: String
		var availability: Availability
	}
	
	enum Availability {
		case available(price: NSDecimalNumber, locale: Locale)
		case unavailable
	}
}

extension UnlockButton.Product {
	init(for product: SKProduct) {
		title = product.localizedTitle
		description = product.localizedDescription
		availability = .available(price: product.price, locale: product.priceLocale)
	}
}

// MARK: - Previews
struct UnlockButton_Previews: PreviewProvider {
	static let availableProduct = UnlockButton.Product(
		title: "Unlock Icon Set 0",
		description: "Lovely Icon Set For You!",
		availability: .available(price: 4.99, locale: .current)
	)
	
	static let unavailableProduct = UnlockButton.Product(
		title: "Unlock Icon Set 0",
		description: "Unavailable for purchase 🙁",
		availability: .available(price: 4.99, locale: .current)
	)
	
    static var previews: some View {
		Group {
			UnlockButton(product: availableProduct, purchaseAction: {})
			UnlockButton(product: unavailableProduct, purchaseAction: {})
		}
		.frame(width: 300)
		.previewLayout(.sizeThatFits)
    }
}
