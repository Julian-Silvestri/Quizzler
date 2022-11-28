//
//  CustomLoader.swift
//  Quizify
//
//  Created by Julian Silvestri on 2022-11-21.
//  Copyright © 2022 Julian Silvestri. All rights reserved.
//

import Foundation
import UIKit

class CustomLoader: UIView {
    
    static let instance = CustomLoader()
    
    var viewColor: UIColor = .black
    var setAlpha: CGFloat = 0.7
    var gifName: String = "Blocks-1s-800px"
    var width: Int = 300
    var height: Int = 300
    
    let keyWindow = UIApplication.shared.connectedScenes
    .filter({$0.activationState == .foregroundActive})
    .map({$0 as? UIWindowScene})
    .compactMap({$0})
    .first?.windows
    .filter({$0.isKeyWindow}).first
    
    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        transparentView.backgroundColor = viewColor.withAlphaComponent(setAlpha)
        transparentView.isUserInteractionEnabled = false
        return transparentView
    }()
    
    lazy var gifImage: UIImageView = {
        var gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(asset: gifName)
        return gifImage
    }()
    
    func showLoaderView() {
        self.addSubview(self.transparentView)
        self.transparentView.addSubview(self.gifImage)
        self.transparentView.bringSubviewToFront(self.gifImage)
        keyWindow?.addSubview(transparentView)
    }
    
    func hideLoaderView() {
        self.transparentView.removeFromSuperview()
    }
    
}
