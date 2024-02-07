//
//  ContentView.swift
//  WeSplit
//
//  Created by Lucas Pennice on 04/02/2024.
//

import SwiftUI

let currencyFormat = Locale.current.currency?.identifier ?? "USD"

let tipPercentages = [0,10,15,20,25]

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused : Bool
    
    private var total : Double {
        let tipMultiplier = Double(tipPercentage) / 100 + 1.0
        
        let result = checkAmount * tipMultiplier
        
        return result
    }
    
    private var totalPerPerson : Double {
        let result = numberOfPeople == 0 ? 0 : total / Double(numberOfPeople)
        
        return result
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Check total cost") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyFormat))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section("How many people?") {
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<50){Text("\($0) people")}
                    }
                }
                
                Section("How much do you want to tip?") {
                    
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101, id: \.self){
                            Text("\($0)%")
                        }
                        
                    }
                    .pickerStyle(.wheel)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: currencyFormat))
                }

                Section("Check + Tip") {
                    Text(total, format: .currency(code: currencyFormat))
                }

            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done"){amountIsFocused = false}
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
 
