//
//  EditPersonView.swift
//  iOS5-Duenow-Han
//
//  Created by Pia Dünow on 08.01.24.
//

//TODO: delte changes from enditedPerson when cancel is pressed

import SwiftUI

struct EditPersonView: View {
    @ObservedObject var viewModel: ViewModel
    var person: AddressCard
    @Binding var isEditing: Bool
    @State var editedPerson: AddressCard
    @State private var newHobby: String = ""
    
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
                    List{
                        ForEach(editedPerson.hobbies.indices, id: \.self) { index in
                            HStack {
                                TextField("Hobby \(index + 1)", text: $editedPerson.hobbies[index].name)
                                
                                //                                Button(action: {
                                //                                    editedPerson.hobbies.remove(at: index)
                                //                                }) {
                                //                                    Image(systemName: "minus.circle.fill")
                                //                                        .foregroundColor(.red)
                                //                                }
                            }
                        }
                        .onDelete { indices in
                            editedPerson.hobbies.remove(atOffsets: indices)
                        }
                    }
                    
                    HStack {
                        TextField("New Hobby", text: $newHobby)
                        Button(action: {
                            if !newHobby.isEmpty {
                                editedPerson.hobbies.append(Hobby(name: newHobby))
                                newHobby = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
                
                Section(header: Text("Friends")) {
                    ForEach(person.friendIDs, id: \.self) { id in
                        Text("\(viewModel.findAddressCard(by: id)?.firstName ?? "Unknown") \(viewModel.findAddressCard(by: id)?.lastName ?? "")")
                    }
                    Button(action: {
                        
                    }) {
                        Label("Add Friend", systemImage: "person.badge.plus")
                    }
                    .foregroundColor(.accentColor)
                }
            }
            .onAppear {
                editedPerson = person
            }
            .navigationTitle("Edit Contact")
            .navigationBarItems(leading: Button("Cancel") {
                isEditing = false
                editedPerson = person
            }, trailing: Button("Save") {
                viewModel.changeCard(cardID: person.id, changedCard: editedPerson)
                isEditing = false
            })
        }
    }
}

#Preview {
    let viewModel = ViewModel()
    let person = viewModel.members[0]
    
    return NavigationView{DetailView(viewModel: viewModel, person: person)}
}

