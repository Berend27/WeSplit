//
//  ContentView.swift
//  WeSplit
//
//  Created by Dexter Berend on 12/3/23.
//

import SwiftUI

struct ContentView: View {
  @FocusState private var amountIsFocused: Bool
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercenage = 20
  
  let tipPercentages = [10, 15, 20, 25, 0]
  
  var grandTotal: Double {
    let tipSelection = Double(tipPercenage)
    let tipValue = checkAmount / 100 * tipSelection
    return checkAmount + tipValue
  }
  
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let amountPerPerson = grandTotal / peopleCount
    return amountPerPerson
  }
  
  var body: some View {
    if #available(iOS 16, *) {
      NavigationStack {
        Form {
          Section {
            TextField("Amount", value: $checkAmount, format: .currency(code:Locale.current.currency?.identifier ?? "USD"))
              .keyboardType(.decimalPad)
              .focused($amountIsFocused)
            
            Picker("Number of people", selection: $numberOfPeople) {
              ForEach(2..<100) {
                Text("\($0) people")
              }
            }
//            .pickerStyle(.menu)  // default but with blue text
//            .pickerStyle(.navigationLink)
          }
          
          Section("How much tip do you want to leave?") {
            Picker("Tip percentage", selection: $tipPercenage) {
//              ForEach(tipPercentages, id: \.self) {
//                Text($0, format: .percent)
//              }
              ForEach(0..<101, id: \.self) {  // id is not needed here but it doesn't hurt
                Text($0, format: .percent)
              }
            }
//            .pickerStyle(.segmented)
            .pickerStyle(.navigationLink)
          }
          
          Section("Amount per person") {
            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
          }
          
          Section("Total Amount for the Check") {
            Text(grandTotal, format:
                .currency(code: Locale.current.currency?.identifier ?? "USD"))
          }
        }
        .navigationTitle("WeSplit")
        .toolbar {
          if amountIsFocused {
            Button("Done") {
              amountIsFocused = false
            }
          }
        }
      }
    } else {
      // Fallback on earlier versions
    }
    
  }
}

#Preview {
    ContentView()
}


// Creating views in a loop
//struct ContentView: View {
//    let students = ["Harry", "Hermione", "Ron"]
//    @State private var selectedStudent = "Harry"
//    
//    var body: some View {
//        if #available(iOS 16.0, *) {
//            NavigationStack {
//                Form {
//                    Picker("Select your student", selection: $selectedStudent) {
//                        ForEach(students, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                }
//            }
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//}
