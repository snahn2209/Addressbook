//
//  DetailView.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    let person: AddressCard
    
    var body: some View {
        List {
            Section(header: Text("Address")) {
                Text("\(person.street), \(person.zip) \(person.city)")
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
                    ForEach(person.friendIDs, id: \.self) { friendID in
                        // You can display friend information here based on friendID
                        // For example, you can fetch the friend's details from your data source
                        // and display them in a list or as needed.
                        Text("Friend ID: \(friendID)")
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("\(person.firstName) \(person.lastName)")
        .onDisappear {viewModel.updateViews()}
        
        
        //    VStack {
        //        List {
        //            VStack(alignment: .leading) {
        //                Text("Addresse")
        //                    .foregroundColor(.gray)
        //                Text("\(person.street)\n\(person.zip) \(person.city)")
        //            }
        //        }
        //        Text("Hobbies")
        //        Spacer()
        //    }
        //    .navigationTitle("\(person.firstName) \(person.lastName)")
        //    .onDisappear {viewModel.updateViews()}
    }
}

//for later
struct ListField: View {
    let data: String
    
    var body: some View {
        return EmptyView()
    }
}

#Preview {
    NavigationView{DetailView(person: AddressCard(
        firstName: "Laura",
        lastName: "Müller",
        street: "Straße",
        zip: 12345,
        city: "Berlin",
        hobbies: [Hobby(name: "Hobby1"), Hobby(name: "Hobby2")] ,
        friends: [AddressCard.ID]()
    ))}
}
