//
//  DetailView.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var isEditing = false
    var person: AddressCard
    
    var body: some View {
        List {
            Section(header: Text("Address")) {
                Text("\(person.street), \(String(person.zip)) \(person.city)")
            }
            
            Section(header: Text("Hobbies")) {
                if person.hobbies.isEmpty {
                    Text("No hobbies listed")
                        .foregroundColor(.gray)
                } else {
                    ForEach(person.hobbies) { hobby in
                        Text(hobby.name)
                    }
                }
            }
            
            Section(header: Text("Friends")) {
                if person.friendIDs.isEmpty {
                    Text("No friends listed")
                        .foregroundColor(.gray)
                } else {
                    ForEach(person.friendIDs, id: \.self) { id in
                        Text("\(viewModel.findAddressCard(by: id)?.firstName ?? "Unknown") \(viewModel.findAddressCard(by: id)?.lastName ?? "")")
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button(action: {isEditing.toggle()}, label: {
            Text("Edit")
        }))
        .navigationTitle("\(person.firstName) \(person.lastName)")
        .sheet(isPresented: $isEditing, content: {
            NavigationView{
                EditPersonView(viewModel: viewModel ,person: person, isEditing: $isEditing)
            }
        })
        .onDisappear {viewModel.updateViews()}
        
        
    }
}


#Preview {
    let viewModel = ViewModel()
    let person = viewModel.members[0]
    
    return NavigationView{DetailView(viewModel: viewModel, person: person)}
}
