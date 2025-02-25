//
//  Tokenized_Model.swift
//  CNH Demo
//
//  Created by Jason Cusack on 2/25/25.
//

import Foundation

struct Tokenized_Calculator {
    func tokenize(_ input: String) -> [Token] {
        var tokens: [Token] = []
        var currentNumber = ""
        
        for char in input {
            if char.isNumber || char == "." {
                currentNumber.append(char)
            } else {
                // Save any number we've been building
                if !currentNumber.isEmpty {
                    if let number = Double(currentNumber) {
                        tokens.append(.number(number))
                    }
                    currentNumber = ""
                }
                
                // Process operator
                switch char {
                case "+": tokens.append(.plus)
                case "-": tokens.append(.minus)
                case "*", "×": tokens.append(.multiply)
                case "/", "÷": tokens.append(.divide)
                default: tokens.append(.unknown(char))
                }
            }
        }
        
        // Add the last number if there is one
        if !currentNumber.isEmpty, let number = Double(currentNumber) {
            tokens.append(.number(number))
        }
        
        return tokens
    }
    
    func evaluate(_ tokens: [Token]) -> Result<Double, CalculatorError> {
        for token in tokens {
            if case .unknown(_) = token {
                return .failure(.invalidExpression)
            }
        }
        
        // Best to ensure first that we have at least one number
        guard tokens.contains(where: {
            if case .number(_) = $0 { return true }
            return false
        }) else {
            return .failure(.invalidExpression)
        }
        
        var tempTokens = tokens
        
        // First pass: multiply and divide
        var i = 1
        while i < tempTokens.count {
            if case .multiply = tempTokens[i],
               case .number(let left) = tempTokens[i-1],
               i+1 < tempTokens.count,
               case .number(let right) = tempTokens[i+1] {
                
                tempTokens[i-1] = .number(left * right)
                tempTokens.remove(at: i)
                tempTokens.remove(at: i)
                
            } else if case .divide = tempTokens[i],
                      case .number(let left) = tempTokens[i-1],
                      i+1 < tempTokens.count,
                      case .number(let right) = tempTokens[i+1] {
                
                if right == 0 {
                    return .failure(.divisionByZero)
                }
                
                tempTokens[i-1] = .number(left / right)
                tempTokens.remove(at: i)
                tempTokens.remove(at: i)
                
            } else {
                i += 1
            }
        }
        
        // Second pass: addition and subtraction
        i = 1
        while i < tempTokens.count {
            if case .plus = tempTokens[i],
               case .number(let left) = tempTokens[i-1],
               i+1 < tempTokens.count,
               case .number(let right) = tempTokens[i+1] {
                
                tempTokens[i-1] = .number(left + right)
                tempTokens.remove(at: i)
                tempTokens.remove(at: i)
                
            } else if case .minus = tempTokens[i],
                      case .number(let left) = tempTokens[i-1],
                      i+1 < tempTokens.count,
                      case .number(let right) = tempTokens[i+1] {
                
                tempTokens[i-1] = .number(left - right)
                tempTokens.remove(at: i)
                tempTokens.remove(at: i)
                
            } else {
                i += 1
            }
        }
        
        // The result should be a single number token
        if tempTokens.count == 1, case .number(let result) = tempTokens[0] {
            return .success(result)
        } else {
            return .failure(.invalidExpression)
        }
    }
    
    func evaluateExpression(_ expression: String) -> String {
        let tokens = tokenize(expression)
        
        // Check if the expression is valid
        for token in tokens {
            if case .unknown(let char) = token {
                return "Invalid character: \(char)"
            }
        }
        
        let result = evaluate(tokens)
        
        switch result {
        case .success(let value):
            // Format the result to avoid trailing zeros
            if value.truncatingRemainder(dividingBy: 1) == 0 {
                return "\(Int(value))"
            } else {
                return "\(value)"
            }
        case .failure(let error):
            return error.localizedDescription
        }
    }
}
