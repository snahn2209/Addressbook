//
//  EditPersonView.swift
//  iOS5-Duenow-Han
//
//  Created by Pia Dünow on 08.01.24.
//

import SwiftUI

struct EditPersonView: View {
    @ObservedObject var viewModel: ViewModel
    var person: AddressCard
    @Binding var isEditing: Bool
    @State var editedPerson: AddressCard
    
    init(viewModel: ViewModel, person: AddressCard, isEditing: Binding<Bool>) {
        self.viewModel = viewModel
        self.person = person
        self._isEditing = isEditing
        self._editedPerson = State(initialValue: person)
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("First Name", text: $editedPerson.firstName)
                    TextField("Last Name", text: $editedPerson.lastName)
                }
                
                Section(header: Text("Address")) {
                    TextField("Street", text: $editedPerson.street)
                    TextField("ZIP", value: $editedPerson.zip, formatter: NumberFormatter())
                    TextField("City", text: $editedPerson.city)
                }
                
                Section(header: Text("Hobbies")) {
                    ForEach(0..<editedPerson.hobbies.count, id: \.self) { index in
                        TextField("Hobby \(index + 1)", text: $editedPerson.hobbies[index].name)
                    }
                }
            }
        }
        .navigationTitle("Edit Contact")
        .navigationBarItems(leading: Button("Cancel") {
            isEditing = false
        }, trailing: Button("Save") {
            viewModel.changeCard(cardID: person.id, changedCard: editedPerson)
            isEditing = false
        })
    }
}


#Preview {
    let viewModel = ViewModel()
    let person = viewModel.members[0]
    
    return NavigationView{DetailView(viewModel: viewModel, person: person)}
}
