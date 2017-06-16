//
//  ViewController.swift
//  Calculator
//
//  Created by Illarionova Violetta on 10/03/2017.
//  Copyright © 2017 Disruptvioletta LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         /*brain.addUnaryOperation(named: "✅") { [weak weakSelf = self] in // unowned self self.displayLabel
            weakSelf?.displayLabel.textColor = UIColor.green
            return sqrt($0)
        } */
    }
//    
//    private func showSizeClasses() {
//        if !userIsInTheMiddleOfTyping {
//            displayLabel.textAlignment = .center
//            displayLabel.text = "width " + traitCollection.horizontalSizeClass.description + " height " + traitCollection.verticalSizeClass.description
//        }
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        showSizeClasses()
//    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { coordinator in
        }, completion: nil)
    }

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

extension UIUserInterfaceSizeClass: CustomStringConvertible {
    public var description: String {
        switch self {
        case .compact: return "Compact"
        case .regular: return "Regular"
        case .unspecified: return "Unspecified"
        }
    }
}





