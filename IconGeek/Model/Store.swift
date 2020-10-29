//
//  StoreKit.swift
//  IconGeek
//
//  Model that handles digital purchases (IAPs)
//  Created by Brainflash on 28/10/2020.
//

import StoreKit

typealias FetchCompletionHandler = (([SKProduct]) -> Void)
typealias PurchaseCompletionHandler = ((SKPaymentTransaction?) -> Void)

class Store: NSObject, ObservableObject {
	@Published var unlockedIconSet1: Bool = false
	@Published var unlockedIconSet2: Bool = false

	@Published var productIconSet1: SKProduct?
	@Published var productIconSet2: SKProduct?

	private let allProductIdentifiers = Set([
		Store.ProductIdentifier.IconSet1,
		Store.ProductIdentifier.IconSet2
	])
	
	private var fetchedProducts = [SKProduct]()
	private var productsRequest: SKProductsRequest?
	private var fetchCompletionHandler: FetchCompletionHandler?
	private var purchaseCompletionHandler: PurchaseCompletionHandler?

	override init() {
		super.init()
		
		// Get notified when access to a product is revoked
		startObservingPaymentQueue()
		fetchProducts { [weak self] products in
			guard let self = self else { return }
			self.productIconSet1 = products.first(where: { $0.productIdentifier == Store.ProductIdentifier.IconSet1 })
			self.productIconSet2 = products.first(where: { $0.productIdentifier == Store.ProductIdentifier.IconSet2 })
		}
	}
}

// MARK: - Store API

extension Store {
	struct ProductIdentifier {
		static let IconSet1 = "app.icongeek.iconset1"
		static let IconSet2 = "app.icongeek.iconset2"
	}
	
	func product(for identifier: String) -> SKProduct? {
		return fetchedProducts.first(where: { $0.productIdentifier == identifier })
	}
}

// MARK: - Private logic

extension Store {
	
	private func fetchProducts(_ completion: @escaping FetchCompletionHandler) {
		guard self.productsRequest == nil else {
			return
		}
		// Store our completion handler for later
		fetchCompletionHandler = completion
		
		// Create and start this product request
		productsRequest = SKProductsRequest(productIdentifiers: allProductIdentifiers)
		productsRequest?.delegate = self
		productsRequest?.start()
	}
	
	private func startObservingPaymentQueue() {
		SKPaymentQueue.default().add(self)
	}
}

// MARK: - SKPaymentTransactionObserver

extension Store: SKPaymentTransactionObserver {
	func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		
	}
	
}

// MARK: - SKProductsRequestDelegate

extension Store: SKProductsRequestDelegate {
	func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		
	}
	
}
