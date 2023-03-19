//
//  ContentView.swift
//  SomeWorks
//
//  Created by Sultan on 17.03.2023.
//

import SwiftUI

struct ContentView: View {
    let percentage = [0,5,10,15,20]
    @State private var personNumber = 0
    @State private var currentCost = 0.00
    @State private var currentTip = 0
    @FocusState private var amountIsFocused: Bool
    
    var separateCost : Double {
        let peopleCount = Double(personNumber + 2)
        let tip = Double(currentTip)
        
        let tipValue = (currentCost / 100) * tip
        let grandTotal = tipValue + currentCost
        let separateCost = grandTotal / peopleCount
        
        return separateCost
    }
    
    var totalCost: Double{
        let tip = Double(currentTip)
        
        let tipValue = (currentCost / 100) * tip
        let grandTotal = tipValue + currentCost
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Price", value: $currentCost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $personNumber){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Current information")
                }
                Section{
                    Picker("Tip percentage", selection: $currentTip){
                        ForEach(percentage, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Percentage of Tip")
                }
                
                Section{
                    Text(separateCost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Cost for each person")
                }
                
                Section{
                    Text(totalCost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total Cost")
                }
            }
            .navigationTitle("FairSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
