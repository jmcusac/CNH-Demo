//
//  Tokenized_ViewModel.swift
//  CNH Demo
//
//  Created by Jason Cusack on 2/25/25.
//

import Foundation
import Combine

class Tokenized_CalculatorViewModel: ObservableObject {
    private let calculator = Tokenized_Calculator()
    
    @Published var inputExpression: String = ""
    @Published var result: String = ""
    @Published var tokens: [Token] = []
    
    func evaluateExpression() {
        tokens = calculator.tokenize(inputExpression)
        result = calculator.evaluateExpression(inputExpression)
    }
    
    func getTokensDescription() -> String {
        return tokens.map { token in
            switch token {
            case .number(let value):
                return "Number(\(value))"
            case .plus:
                return "Plus"
            case .minus:
                return "Minus"
            case .multiply:
                return "Multiply"
            case .divide:
                return "Divide"
            case .unknown(let char):
                return "Unknown(\(char))"
            }
        }.joined(separator: ", ")
    }
}
