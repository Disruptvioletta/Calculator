//
//  ViewController.swift
//  Calculator
//
//  Created by Illarionova Violetta on 10/03/2017.
//  Copyright © 2017 Disruptvioletta LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func typeDigitButton(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = displayLabel!.text!
            displayLabel!.text = textCurrentlyInDisplay + digit
        } else {
            displayLabel!.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()

    @IBAction func performOperationButton(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false

        }
        if let mathmatecalSymbol = sender.currentTitle {
            brain.performOperation(mathmatecalSymbol)
        }
        if let  result = brain.getResult {
            displayValue = result
        }
    }

}

