//
//  AddPersonView.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 06.01.24.
//

import Foundation
import SwiftUI

struct AddPersonView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ViewModel
    @State var newPerson = AddressCard(firstName: "", lastName: "", street: "", zip: 12345, city: "", friends: [])
    @State private var isValid: Bool = false
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Name")) {
                    TextField("First Name", text: $newPerson.firstName)
                    TextField("Last Name", text: $newPerson.lastName)
            }
                Section(header: Text("Address")) {
                    TextField("Street", text: $newPerson.street)
                    TextField("ZIP", text: Binding(
                        get: { String(newPerson.zip) },
                        set: { newPerson.zip = Int($0) ?? 0 }))
                        .keyboardType(.numberPad)
                    TextField("City", text: $newPerson.city)
            }
                Section{
                    Button("Save"){
                        viewModel.addCard(newContact: newPerson)
                        presentationMode.wrappedValue.dismiss()
                    }
                    //.disabled(!isValid)
                }

                
        }
        .navigationTitle("New Contact")
        /*.onChange(of: newPerson) { _ in
                    // Update the isValid flag whenever newPerson changes
                    isValid = validateInputs()
                }*/
        .navigationBarItems(trailing:
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    /*private func validateInputs() -> Bool {
            // Implement your validation logic here
            // Example: Check if required fields are not empty, etc.
            return !newPerson.firstName.isEmpty && !newPerson.lastName.isEmpty
        }*/
}

#Preview {
    AddPersonView(viewModel: ViewModel())
}
