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
    
    enum Operation:String{
        case Divide="/"
        case Multiply="*"
        case Subtraction="-"
        case Addition="+"
        case Empty="Empty"
    }
    
    var runningNumber="0"
    var currentOperation=Operation.Empty
    var leftHandValue=""
    var rightHandValue=""
    var result=""
    
    
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
        runningNumber+="\(sender.tag)"
        resultLbl.text=runningNumber
    }
    
    @IBAction func onDividePressed(sender:AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender:AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onAdditionPressed(sender:AnyObject){
        processOperation(operation: .Addition)
    }
    
    @IBAction func onSubtractionPressed(sender:AnyObject){
        processOperation(operation: .Subtraction)
    }
    
    @IBAction func onEqualPressed(sender:AnyObject){
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(_ sender: Any) {
        playSound()
        runningNumber="0"
        result=""
        currentOperation=Operation.Empty
        resultLbl.text=runningNumber
    }
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation:Operation){
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightHandValue=runningNumber
                runningNumber=""
                
                if currentOperation == Operation.Multiply {
                    result="\(Double(leftHandValue)! * Double(rightHandValue)!)"
                }else if currentOperation == Operation.Divide {
                    result="\(Double(leftHandValue)! / Double(rightHandValue)!)"
                }else if currentOperation == Operation.Addition {
                    result="\(Double(leftHandValue)! + Double(rightHandValue)!)"
                }else if currentOperation == Operation.Subtraction {
                    result="\(Double(leftHandValue)! - Double(rightHandValue)!)"
                }
                leftHandValue=result
                resultLbl.text=result
        
            }
            currentOperation=operation

        }else{
            leftHandValue=runningNumber
            runningNumber=""
            currentOperation=operation
            
        }
    }

}

