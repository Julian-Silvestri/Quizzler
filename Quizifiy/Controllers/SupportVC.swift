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

    @IBOutlet weak var restorePurchaseBtn: UIButton!
    @IBOutlet weak var faqBtn: SupportButtons!
    @IBOutlet weak var contactBtn: SupportButtons!
    @IBOutlet weak var removeAdsLabel: QuizLabels!
    @IBOutlet weak var removeAdsBtn: UIButton!
    var bgColor = #colorLiteral(red: 0.9570063949, green: 0.8126075864, blue: 0.3806093335, alpha: 1)
    var txtColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    private var hiddenStatus: Bool = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseWasMade")
    
    var alert: UIAlertController?
    var hideAds = UserDefaults.standard.value(forKey: "hideAds") as? String
//    var action: UIAlertAction?
//    var products_ = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchase(_:)), name: NSNotification.Name(IAPServicePurchaseNotification), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(handleFailure), name: NSNotification.Name(IAPServiceFailureNotification), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(showRestoredAlert), name: NSNotification.Name(IAPServiceRestoreNotification), object: nil)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       //showOrHideAds()
        self.removeAdsBtn.layer.cornerRadius = 12
        self.removeAdsBtn.backgroundColor = bgColor
        self.removeAdsBtn.titleLabel?.font = UIFont(name: "Avenir Next", size: 38)
        self.removeAdsBtn.titleLabel?.textColor = txtColor
        if(hideAds == "true"){
            self.removeAdsBtn.setTitle("Restore Purchase", for: .normal)
        } else{
            self.removeAdsBtn.setTitle("Remove Ad's", for: .normal)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

//    @objc func handlePurchase(_ notification: Notification) {
//        guard let productID = notification.object as? String else { return }
//
//        switch productID {
//        case IAP_HIDE_ADS_ID:
////            self.removeAdsBtn.isHidden = true
////            self.removeAdsLabel.isHidden = true
//            debugPrint("Hide Ads Purchased!")
//            break
//        default:
//            break
//        }
//    }
    

    @IBAction func faqBtnPress(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://www.jsilvestri.ca")!)
    }
    
    @IBAction func contactBtnPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://www.jsilvestri.ca")! )
    }
//    func showRestoredAlert() {
//
//        let alertController = UIAlertController(title: "Success!", message: "Your purchase was successfully restored.", preferredStyle: .alert)
//        //...
////        var rootVC = UIWindowScene.
//        var rootViewController = self.view.window?.rootViewController
//        if let navigationController = rootViewController as? UINavigationController {
//            rootViewController = navigationController.viewControllers.first
//        }
//        if let tabBarController = rootViewController as? UITabBarController {
//            rootViewController = tabBarController.selectedViewController
//        }
//        //...
//        rootViewController?.present(alertController, animated: true, completion: nil)
//
//    }
//
//    @objc func handleFailure() {
//        removeAdsBtn.isEnabled = true
//        debugPrint("Purchase Failed!")
//    }
    
//    @IBAction func restorePurchasesBtnAction(_ sender: Any) {
//        print("restoring purchases")
//        IAPService.sharedInstance.restorePurchases()
//    }
//    func showOrHideAds() {
//        self.removeAdsLabel.isHidden = hiddenStatus
//        self.removeAdsBtn.isHidden = hiddenStatus
//    }
//
//    @IBAction func removeAdsBtnAction(_ sender: Any) {
////        getReceiptData()
//        if(UserDefaults.standard.value(forKey: "hideAds") as? String == "true"){
//            IAPService.sharedInstance.restorePurchases()
//        } else{
//            IAPService.sharedInstance.fetchProducts()
//        }
//    }
    
    
//    func getReceiptData(){
//        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
//            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {
//
//
//            do {
//                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
//                print(receiptData)
//
//
//                let receiptString = receiptData.base64EncodedString(options: [])
//
//
//                // Read receiptData.
//
//                print("RECIEPT DATA => \(receiptString)")
//            }
//            catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
//        }
//    }


}
