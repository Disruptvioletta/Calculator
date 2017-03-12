//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Illarionova Violetta on 10/03/2017.
//  Copyright © 2017 Disruptvioletta LLC. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    
    
    private enum DifferentOperations {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double,Double) -> Double)
        case equals
    }
    
    
    private var operationsDict: Dictionary <String,DifferentOperations> = [
        "π"  : .constant(M_PI),
        "√"  : .unary(sqrt),
        "e"  : .constant(M_E),
        "cos": .unary(cos),
        "×"  : .binary( {$0 * $1 }),
        "-"  : .binary( {$0 - $1 }),
        "+"  : .binary( {$0 + $1 }),
        "÷"  : .binary( {$0 / $1 }),
        "="  : .equals
        ]
    
    mutating func performOperation (_ symbol: String ) {
        if let temporaryConstant = operationsDict[symbol] {
            switch temporaryConstant {
            case .constant(let value):
                accumulator = value
            case .unary(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binary(let function) :
                if accumulator != nil {
                pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals :
                performPendingBinaryOperation()
            }// end of switch statement
            
        } // end if
        
    }//  end func
    
    mutating private func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
        accumulator = pendingBinaryOperation!.perform(With: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation : PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(With  secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }

    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }

    
    var getResult: Double? {
        get {
            return accumulator
        }
        
    }
}
