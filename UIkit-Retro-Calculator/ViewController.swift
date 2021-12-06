//
//  ViewController.swift
//  UIkit-Retro-Calculator
//
//  Created by Pavan Mikkilineni on 04/12/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var resultLbl: UILabel!
    var btnSound:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLbl.text="0"
        let soundURL=Bundle.main.url(forResource:"RetroCalculator_btn" , withExtension: "wav")!
        
        do{
            btnSound=try AVAudioPlayer(contentsOf: soundURL)
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(sender:UIButton){
        playSound()
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }

}

