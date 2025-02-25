//
//  Tokenized_View.swift
//  CNH Demo
//
//  Created by Jason Cusack on 2/25/25.
//

import SwiftUI

struct Tokenized_CalculatorView: View {
    @StateObject private var viewModel = Tokenized_CalculatorViewModel()
    @State private var showTokens = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Tokenized Calculator")
                .font(.largeTitle)
                .padding()
            
            TextField("Enter expression", text: $viewModel.inputExpression)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .submitLabel(.done)
            
            Button("Calculate") {
                viewModel.evaluateExpression()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Text(viewModel.result)
                .font(.title)
                .padding()
            
            if !viewModel.tokens.isEmpty {
                ScrollView {
                    Text(viewModel.getTokensDescription())
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .frame(height: 100)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    Tokenized_CalculatorView()
}
