//
//  IAPService.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-07-14.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//
import Foundation
import StoreKit

protocol IAPServiceDelegate {
    func iapProductsLoaded()
}

class IAPService: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //MARK: IN APP PURCHASES
    
    static let sharedInstance = IAPService()
    
    private var products = [SKProduct]()
    private var productBeingPurchased: SKProduct?
    
    
    enum Product: String, CaseIterable{
        case hideAds = "silvestri.QuizifyAdFree"
    }
    
    //Fetch Product Objects from apple
    public func fetchProducts(){
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({$0.rawValue})))
        request.delegate = self
        request.start()
        print("request started")
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
//        response.products.first
        guard let product = products.first else {
            return
        }
        purchase(product: product)
        print("products Request function ")
    }
    
    func getSKProductObject(){

        
        return
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        guard request is SKProductsRequest else {
            return
        }
        print("product fetch request failed")
    }
    
    //prompt a product payment transaction
    public func purchase(product: SKProduct){
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        
        productBeingPurchased = product
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
        print("TRYING TO PURCHASE")
    }

    //observe the transaction state
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        transactions.forEach({ transaction in
            
            switch transaction.transactionState {
            case .purchasing:
                print("Transaction state purchasing = \(transaction.transactionState)")
                break
            case .purchased:
                print("Transaction state purchased = \(transaction.transactionState)")
                handlePurchase(transaction.payment.productIdentifier)
                break
            case .restored:
                print("Transaction state restored = \(transaction.transactionState)")
                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
//                handlePurchase(transaction.payment.productIdentifier)
                print("??????????????????????")
                break
            case .failed:
                print("Transaction state failed = \(transaction.transactionState)")
                break
            case .deferred:
                print("Transaction state deferred = \(transaction.transactionState)")
                break
            @unknown default:
                print("FATAL ERROR UNKNOWN PAYMENT QUEUE")
                break
            }
        })
    }
    private func handlePurchase(_ id: String){
        print("PURCHAAAAAAASED!!!")

    }
    
    func restorePurchases(){
        print("RESTORING PURCHASES (1)")
        SKPaymentQueue.default().add(self)
        if(SKPaymentQueue.canMakePayments()){
            print("RESTORING PURCHASES (2)")
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
      print("paymentQueueRestoreCompletedTransactionsFinished() called")
//        SKPaymentQueue.default().restoreCompletedTransactions()
        
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            let prodID = t.payment.productIdentifier as String

            switch prodID {
            case "silvestri.QuizifyAdFree":
                print("Transaction state restored = \(transaction.transactionState)")
                SKPaymentQueue.default().finishTransaction(transaction as SKPaymentTransaction)
                break
                // implement the given in-app purchase as if it were bought
            default:
                print("iap not found")
            }
        }
    }

    func paymentQueue(_ queue: SKPaymentQueue,
                      restoreCompletedTransactionsFailedWithError error: Error) {
      print("paymentQueue - error func called")
    }
    
//    static let instance = IAPService()
//
//    var delegate: IAPServiceDelegate?
//
//    var products = [SKProduct]()
//    var productIds = Set<String>()
//    var productRequest = SKProductsRequest()
//
//    var nonConsumablePurchaseWasMade = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseWasMade")
//
//    override init() {
//        super.init()
//        SKPaymentQueue.default().add(self)
//    }
//
//    func loadProducts() {
//        productIdToStringSet()
//        requestProducts(forIds: productIds)
//
//    }
//
//    func productIdToStringSet() {
////        let ids = [IAP_HIDE_ADS_ID]
////        for id in ids {
////            productIds.insert(id)
////        }
//
//        productIds.insert(IAP_HIDE_ADS_ID)
//
//        print("prodcuts inserted into products array")
//    }
//
//    func requestProducts(forIds ids: Set<String>) {
//        productRequest.cancel()
//        productRequest = SKProductsRequest(productIdentifiers: ids)
//        productRequest.delegate = self
//        productRequest.start()
//        print("product request started")
//    }
//
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        self.products = response.products
//        print("PRODUCT REQUEST BEGUN")
//
//        if products.count == 0 {
//            requestProducts(forIds: productIds)
//        } else {
//            delegate?.iapProductsLoaded()
//            print("PRODUCTS FINISHED LOADING")
//        }
//    }
//
//    func attemptPurchaseForItemWith(productIndex: Product) {
//        let product = products[productIndex.rawValue]
//        let payment = SKPayment(product: product)
//        SKPaymentQueue.default().add(payment)
//        print("PAYMENT QUEUE ADDED")
//    }
//
//    func restorePurchases() {
//        SKPaymentQueue.default().restoreCompletedTransactions()
//    }
//}
//
//extension IAPService: SKPaymentTransactionObserver {
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        for transaction in transactions {
//            switch transaction.transactionState {
//            case .purchased:
//                SKPaymentQueue.default().finishTransaction(transaction)
//                complete(transaction: transaction)
//                sendNotificationFor(status: .purchased, withIdentifier: transaction.payment.productIdentifier)
//                debugPrint("Purchase was successful!")
//                break
//            case .restored:
//                SKPaymentQueue.default().finishTransaction(transaction)
//                break
//            case .failed:
//                SKPaymentQueue.default().finishTransaction(transaction)
//                sendNotificationFor(status: .failed, withIdentifier: nil)
//                break
//            case .deferred:
//                break
//            case .purchasing:
//                break
//            @unknown default:
//                fatalError()
//            }
//        }
//    }
//
//    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
//        sendNotificationFor(status: .restored, withIdentifier: nil)
//        setNonConsumablePurchase(true)
//    }
//
//    func complete(transaction: SKPaymentTransaction) {
//        switch transaction.payment.productIdentifier {
//        case IAP_HIDE_ADS_ID:
//            setNonConsumablePurchase(true)
//            break
//        default:
//            break
//        }
//    }
//
//    func setNonConsumablePurchase(_ status: Bool) {
//        UserDefaults.standard.set(status, forKey: "nonConsumablePurchaseWasMade")
//    }
//
//    func sendNotificationFor(status: PurchaseStatus, withIdentifier identifier: String?) {
//        switch status {
//        case .purchased:
//            NotificationCenter.default.post(name: NSNotification.Name(IAPServicePurchaseNotification), object: identifier)
//            break
//        case .restored:
//            NotificationCenter.default.post(name: NSNotification.Name(IAPServiceRestoreNotification), object: nil)
//            break
//        case .failed:
//            NotificationCenter.default.post(name: NSNotification.Name(IAPServiceFailureNotification), object: nil)
//            break
//        }
//    }
}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
