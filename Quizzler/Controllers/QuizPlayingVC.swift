//
//  QuizPlayingVC.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-09-08.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit
import AVFoundation

class QuizPlayingVC: UIViewController {

    @IBOutlet weak var statusViewContainer: UIView!
    @IBOutlet weak var status1: UIView!
    @IBOutlet weak var status2: UIView!
    @IBOutlet weak var status3: UIView!
    @IBOutlet weak var status4: UIView!
    @IBOutlet weak var status5: UIView!
    @IBOutlet weak var question1: UILabel!
    @IBOutlet weak var quitbtn: UIButton!
    @IBOutlet weak var mainQuizPlayArea: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.status1.layer.cornerRadius = 7
        self.statusViewContainer.layer.cornerRadius = 7
        self.quitbtn.layer.cornerRadius = 5
        self.mainQuizPlayArea.layer.cornerRadius = 5

    }


    @IBAction func quitBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func test(_ sender: Any) {
        
        let utterance = AVSpeechUtterance(string: self.question1.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)

    }
    
}
