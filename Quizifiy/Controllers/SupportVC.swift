//
//  SupportVC.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2022-07-14.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import UIKit

class SupportVC: UIViewController {
    
    @IBOutlet weak var faqBtn: SupportButtons!
    @IBOutlet weak var contactBtn: SupportButtons!
    @IBOutlet weak var removeAdsBtn: SupportButtons!
    @IBOutlet weak var removeAdsLabel: QuizLabels!
    
    private var hiddenStatus: Bool = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseWasMade")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IAPService.instance.delegate = self
        IAPService.instance.loadProducts()
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchase(_:)), name: NSNotification.Name(IAPServicePurchaseNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFailure), name: NSNotification.Name(IAPServiceFailureNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showRestoredAlert), name: NSNotification.Name(IAPServiceRestoreNotification), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showOrHideAds()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func handlePurchase(_ notification: Notification) {
        guard let productID = notification.object as? String else { return }
        
        switch productID {
        case IAP_HIDE_ADS_ID:
            self.removeAdsBtn.isHidden = true
            self.removeAdsLabel.isHidden = true
            debugPrint("Ads hidden!")
            break
        default:
            break
        }
    }
    
    @objc func showRestoredAlert() {
        let alert = UIAlertController(title: "Success!", message: "Your purchases were successfully restored.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handleFailure() {
        removeAdsBtn.isEnabled = true
        debugPrint("Purchase Failed!")
    }
    
    func showOrHideAds() {
        self.removeAdsLabel.isHidden = hiddenStatus
        self.removeAdsBtn.isHidden = hiddenStatus
    }
    
    @IBAction func removeAdsBtnAction(_ sender: Any) {
        IAPService.instance.attemptPurchaseForItemWith(productIndex: .hideAds)
    }

}
extension SupportVC: IAPServiceDelegate {
    func iapProductsLoaded() {
        print("IAP PRODUCTS LOADED!")
    }
}
