//
//  Tokenization_Enumerations.swift
//  CNH Demo
//
//  Created by Jason Cusack on 2/25/25.
//

import Foundation

enum CalculatorError: Error, LocalizedError {
    case invalidExpression
    case divisionByZero
    
    var errorDescription: String? {
        switch self {
        case .invalidExpression:
            return "Invalid expression"
        case .divisionByZero:
            return "Division by zero"
        }
    }
}

enum Token {
    case number(Double)
    case plus
    case minus
    case multiply
    case divide
    case unknown(Character)
}
