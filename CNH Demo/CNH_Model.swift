//
//  CNH_Model.swift
//  CNH Demo
//
//  Created by Jason Cusack on 2/25/25.
//

import SwiftUI

struct Calculator {
    func evaluate(_ expression: String) -> String {
        guard isValidExpression(expression) else {
            return "Invalid expression"
        }
        
        //NSExpression
        let expressionFormatted = expression
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")
        
        let expr = NSExpression(format: expressionFormatted)
        
        guard let result = expr.expressionValue(with: nil, context: nil) as? NSNumber else {
            return "Error"
        }
        
        return "\(result)"
    }
    
    private func isValidExpression(_ expression: String) -> Bool {
        //these are the only characters that were requested to be validated
        let validCharacters = CharacterSet(charactersIn: "0123456789+-/*")
        
        return expression.rangeOfCharacter(from: validCharacters.inverted) == nil
    }
}

/* original version - no longer needed
 
 switch char {
 case "+": tokens.append(.plus)
 case "-": tokens.append(.minus)
 case "*", "×": tokens.append(.multiply)
 case "/", "÷": tokens.append(.divide)
 default: tokens.append(.unknown(char))
 }
 
 enum Token {
 case number(Double)
 case plus
 case minus
 case multiply
 case divide
 case unknown(Character)
 }
 
 */
