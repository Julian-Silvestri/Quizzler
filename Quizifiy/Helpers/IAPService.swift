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
    
    enum ReceiptValidationError: Error {
        case receiptNotFound
        case jsonResponseIsNotValid(description: String)
        case notBought
        case expired
    }
    
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
                SupportVC().showRestoredAlert()
//                handlePurchase(transaction.payment.productIdentifier)
//                print("??????????????????????")
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
        do {
            try validateReceipt()
        } catch {
            print("errr")
        }
        UserDefaults.standard.setValue("true", forKey: "hideAds")
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
                SupportVC().showRestoredAlert()
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
    
    func validateReceipt() throws {
        guard let appStoreReceiptURL = Bundle.main.appStoreReceiptURL, FileManager.default.fileExists(atPath: appStoreReceiptURL.path) else {
            throw ReceiptValidationError.receiptNotFound
        }
        
        let receiptData = try! Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
        let receiptString = receiptData.base64EncodedString()
        let jsonObjectBody = ["receipt-data" : receiptString, "password" : "password"]
        
        #if DEBUG
        let url = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
        #else
        let url = URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
        #endif
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: jsonObjectBody, options: .prettyPrinted)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var validationError : ReceiptValidationError?
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil, httpResponse.statusCode == 200 else {
                validationError = ReceiptValidationError.jsonResponseIsNotValid(description: error?.localizedDescription ?? "")
                semaphore.signal()
                return
            }
            guard let jsonResponse = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [AnyHashable: Any] else {
                validationError = ReceiptValidationError.jsonResponseIsNotValid(description: "Unable to parse json")
                semaphore.signal()
                return
            }
//            guard let expirationDate = self.expirationDate(jsonResponse: jsonResponse, forProductId: String) else {
//                validationError = ReceiptValidationError.notBought
//                semaphore.signal()
//                return
//            }
            
//            let currentDate = Date()
//            if currentDate > expirationDate {
//                validationError = ReceiptValidationError.expired
//            }
            
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        
        if let validationError = validationError {
            throw validationError
        }
    }
}

