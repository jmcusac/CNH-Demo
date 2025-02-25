//
//  CNH_View.swift
//  CNH Demo
//
//  Created by Jason Cusack on 2/25/25.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("String Calculator")
                .font(.largeTitle)
                .padding()
            
            TextField("Erik's Expression Input", text: $viewModel.inputExpression)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .submitLabel(.done)
            
            Button("Calculate") {
                viewModel.evaluateExpression()
            }
            .padding()
            
            Text(viewModel.result)
                .font(.title)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}
