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
	
	// Array of productIconSets, from fetchProducts call
	@Published var productIconSets: [SKProduct]?

	private var model: AppModel?
	
	private let allProductIdentifiers = Set([
		Store.ProductIdentifier.IconSet1,
		Store.ProductIdentifier.IconSet2,
		Store.ProductIdentifier.IconSet3,
		Store.ProductIdentifier.IconSet4,
		Store.ProductIdentifier.IconSet5
	])
	
	private var completedPurchases = [String]()
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
			self.productIconSets = products.filter { self.allProductIdentifiers.contains($0.productIdentifier) }
		}
	}
	
	func inject(_ model: AppModel) {
		self.model = model
	}
}

// MARK: - Store API

extension Store {
	struct ProductIdentifier {
		static let AllSets 		= "app.icongeek.allsets"
		static let IconSet1 	= "app.icongeek.iconset1"
		static let IconSet2 	= "app.icongeek.iconset2"
		static let IconSet3 	= "app.icongeek.iconset3"
		static let IconSet4 	= "app.icongeek.iconset4"
		static let IconSet5 	= "app.icongeek.iconset5"

		static let all: [String] = [
			AllSets,
			IconSet1,
			IconSet2,
			IconSet3,
			IconSet4,
			IconSet5
		]
	}
	
	func product(for identifier: String) -> SKProduct? {
		return fetchedProducts.first(where: { $0.productIdentifier == identifier })
	}
	
	func purchaseProduct(_ product: SKProduct) {
		startObservingPaymentQueue()
		buy(product) { [weak self] transaction in
			guard let self = self,
				  let transaction = transaction else {
				return
			}

			// Unlock the product(s)
			if self.allProductIdentifiers.contains(transaction.payment.productIdentifier),
			   transaction.transactionState == .purchased {

				if let model = self.model {
					if let iconSet = model.iconSets.first(where: { $0.id == transaction.payment.productIdentifier }) {
						iconSet.unlock()
					}
				}
			}

		}
	}
}

// MARK: - Private logic

extension Store {
	
	private func buy(_ product: SKProduct, completion: @escaping PurchaseCompletionHandler) {
		// Save our completion handler for later
		purchaseCompletionHandler = completion
		
		// Create the payment and add it to the queue
		let payment = SKPayment(product: product)
		SKPaymentQueue.default().add(payment)
	}
	
	private func hasPurchasedProduct(_ identifier: String) -> Bool {
		completedPurchases.contains(identifier)
	}
	
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
		var shouldFinishTransaction = false
		for transaction in transactions {
			switch transaction.transactionState {
			case .purchased, .restored:
				completedPurchases.append(transaction.payment.productIdentifier)
				shouldFinishTransaction = true
			case .failed:
				shouldFinishTransaction = true
			case .purchasing, .deferred:
				break
			@unknown default:
				break
			}
			if shouldFinishTransaction {
				SKPaymentQueue.default().finishTransaction(transaction)
				DispatchQueue.main.async {
					self.purchaseCompletionHandler?(transaction)
					self.purchaseCompletionHandler = nil
				}
			}
		}
	}

	func paymentQueue(_ queue: SKPaymentQueue, didRevokeEntitlementsForProductIdentifiers productIdentifiers: [String]) {
		completedPurchases.removeAll(where: { productIdentifiers.contains($0) })
		DispatchQueue.main.async {
			ProductIdentifier.all.forEach { identifier in
				if let model = self.model {
					if let iconSet = model.iconSets.first(where: { $0.id == identifier }) {
						iconSet.lock()
					}
				}
			}
		}
	}
	
}

// MARK: - SKProductsRequestDelegate

extension Store: SKProductsRequestDelegate {
	
	func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		let loadedProducts = response.products
		let invalidProducts = response.invalidProductIdentifiers
		
		guard !loadedProducts.isEmpty else {
			// No valid products found
			var errorMessage = "Could not find any products."
			if !invalidProducts.isEmpty {
				errorMessage = "Invalid products: \(invalidProducts.joined(separator: ", "))"
			}
			print("\(errorMessage)")
			productsRequest = nil
			return
		}
		
		// Cache these for later use
		fetchedProducts = loadedProducts
		
		// Notify anyone waiting on the products
		DispatchQueue.main.async {
			self.fetchCompletionHandler?(loadedProducts)
			
			// Cleanup
			self.fetchCompletionHandler = nil
			self.productsRequest = nil
		}
	}
	
}
