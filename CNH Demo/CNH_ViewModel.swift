//
//  CNH_ViewModel.swift
//  CNH Demo
//
//  Created by Jason Cusack on 2/25/25.
//

import SwiftUI

class CalculatorViewModel: ObservableObject {
    private let calculator = Calculator()
    
    @Published var inputExpression: String = ""
    @Published var result: String = ""
    
    func evaluateExpression() {
        result = calculator.evaluate(inputExpression)
    }
}
