//
//  SupportVC.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-07-14.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit
import StoreKit
//import StoreKit

class SupportVC: UIViewController{
    
    @IBOutlet weak var faqBtn: SupportButtons!
    @IBOutlet weak var contactBtn: SupportButtons!
    @IBOutlet weak var removeAdsBtn: SupportButtons!
    @IBOutlet weak var removeAdsLabel: QuizLabels!
    
//    private var products = [SKProduct]()
//    private var productBeingPurchased: SKProduct?
    
//    public private(set) var item: Item!
    private var hiddenStatus: Bool = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseWasMade")
    
    var alert: UIAlertController?
//    var action: UIAlertAction?
//    var products_ = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.alert = UIAlertController(title: "Success!", message: "Your purchase was successfully restored.", preferredStyle: .alert)
//        self.action = UIAlertAction(title: "OK", style: .default)

//        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchase(_:)), name: NSNotification.Name(IAPServicePurchaseNotification), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(handleFailure), name: NSNotification.Name(IAPServiceFailureNotification), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(showRestoredAlert), name: NSNotification.Name(IAPServiceRestoreNotification), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       //showOrHideAds()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func handlePurchase(_ notification: Notification) {
        guard let productID = notification.object as? String else { return }
        
        switch productID {
        case IAP_HIDE_ADS_ID:
//            self.removeAdsBtn.isHidden = true
//            self.removeAdsLabel.isHidden = true
            debugPrint("Hide Ads Purchased!")
            break
        default:
            break
        }
    }
    
//    func showRestoredAlert() {
//        print("ShOULD show restored alert")
//        self.alert?.addAction(UIAlertAction(title: "OK", style: .default))
//        self.view.addSubview(self.alert?.view ?? UIView())
//        self.view.window?.rootViewController?.present(self.alert ?? UIAlertController(), animated: true, completion: nil)
//    }
    @IBAction func faqBtnPress(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://www.jsilvestri.ca")!)
    }
    
    @IBAction func contactBtnPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://www.jsilvestri.ca")! )
    }
    func showRestoredAlert() {
        
        let alertController = UIAlertController(title: "Success!", message: "Your purchase was successfully restored.", preferredStyle: .alert)
        //...
//        var rootVC = UIWindowScene.
        var rootViewController = self.view.window?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        //...
        rootViewController?.present(alertController, animated: true, completion: nil)
//        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
//        alertWindow.rootViewController = UIViewController()
//
//        let alertController = UIAlertController(title: "Success!", message: "Your purchase was successfully restored.", preferredStyle: UIAlertController.Style.alert)
//        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { _ in
//            alertWindow.isHidden = true
//        }))
//
//        alertWindow.windowLevel = UIWindow.Level.alert + 1;
//        alertWindow.makeKeyAndVisible()
//        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleFailure() {
        removeAdsBtn.isEnabled = true
        debugPrint("Purchase Failed!")
    }
    
    @IBAction func restorePurchasesBtnAction(_ sender: Any) {
        print("restoring purchases")
        IAPService.sharedInstance.restorePurchases()
    }
    func showOrHideAds() {
        self.removeAdsLabel.isHidden = hiddenStatus
        self.removeAdsBtn.isHidden = hiddenStatus
    }
    
    @IBAction func removeAdsBtnAction(_ sender: Any) {
        getReceiptData()
        IAPService.sharedInstance.fetchProducts()
//        self.removeAdsBtn.isHidden = true
//        self.removeAdsLabel.isHidden = true
//        IAPService.sharedInstance.purchase(product: )
//        IAPService.instance.attemptPurchaseForItemWith(productIndex: .hideAds)
    }
    
    
    func validateInAppReceipt(){
//        IAPService.receipt
//        IAPService.validateInAppReceipt()
    }
    
    
    func getReceiptData(){
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {


            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                print(receiptData)


                let receiptString = receiptData.base64EncodedString(options: [])


                // Read receiptData.
                
                print("RECIEPT DATA => \(receiptString)")
            }
            catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
        }
    }


}
//extension SupportVC: SKProductsRequestDelegate, SKPaymentTransactionObserver {
//
//    //MARK: IN APP PURCHASES
//
//    //Fetch Product Objects from apple
//    private func fetchProducts(){
//        let request = SKProductsRequest(productIdentifiers: ["silvestri.QuizifyAdFree"])
//        request.delegate = self
//        request.start()
//    }
//
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        products = response.products
//        guard let product = products.first else {
//            return
//        }
//        purchase(product: product)
//    }
//
//    func request(_ request: SKRequest, didFailWithError error: Error) {
//        guard request is SKProductsRequest else {
//            return
//        }
//        print("product fetch request failed")
//    }
//
//    //prompt a product payment transaction
//    func purchase(product: SKProduct){
//        guard SKPaymentQueue.canMakePayments() else {
//            return
//        }
//
//        productBeingPurchased = product
//
//        let payment = SKPayment(product: product)
//        SKPaymentQueue.default().add(self)
//        SKPaymentQueue.default().add(payment)
//    }
//
//    //observe the transaction state
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        transactions.forEach({ transaction in
//
//            switch transaction.transactionState {
//            case .purchasing:
//                break
//            case .purchased:
//                handlePurchase(transaction.payment.productIdentifier)
//                break
//            case .restored:
//                break
//            case .failed:
//                break
//            case .deferred:
//                break
//            @unknown default:
//                print("FATAL ERROR UNKNOWN PAYMENT QUEUE")
//                break
//            }
//        })
//    }
//    private func handlePurchase(_ id: String){
//
//    }
//}
