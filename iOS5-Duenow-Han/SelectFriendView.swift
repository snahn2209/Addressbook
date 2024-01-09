//
//  SelectFriendView.swift
//  iOS5-Duenow-Han
//
//  Created by Pia Dünow on 09.01.24.
//

import SwiftUI

struct SelectFriendView: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var isEditingFriends: Bool
    @Binding var editedPerson: AddressCard
    var selectedFriends: Binding<[UUID]>
    
    var body: some View {
        NavigationView {
            List(viewModel.members) { person in
                //                Toggle(isOn: $viewModel.members[viewModel.members.firstIndex(of: person)!].friendIDs) {
                //                    Text("\(person.firstName)")
                //                }
                
                Toggle(isOn: Binding(
                    get: {
                        self.selectedFriends.wrappedValue.contains(person.id)
                    },
                    set: { _ in
                        if self.selectedFriends.wrappedValue.contains(person.id) {
                            //self.selectedFriends.wrappedValue.removeAll(where: { $0 == person.id })
                            editedPerson.remove(friend: person)
                        } else {
                            //self.selectedFriends.wrappedValue.append(person.id)
                            editedPerson.add(friend: person)
                        }
                    }
                )) {
                    Text("\(person.firstName) \(person.lastName)")
                }
                
            }
            .navigationTitle("Add Friends")
            .navigationBarItems(leading: Button("Back") {
                isEditingFriends = false
                viewModel.updateViews()
            })
        }
    }
}

#Preview {
    let viewModel = ViewModel()
    let person = viewModel.members[0]
    
    return NavigationView{DetailView(viewModel: viewModel, person: person)}
}
