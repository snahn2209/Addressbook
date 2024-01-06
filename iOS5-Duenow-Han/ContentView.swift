//
//  ContentView.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var isAddPersonViewActive = false
    
    var body: some View {
        NavigationView {
            List(viewModel.members) { person in
                NavigationLink(destination: DetailView(person: person)){
                    VStack(alignment: .leading) {
                        Text("\(person.firstName) \(person.lastName)")
                            .font(.headline)
                        Text("\(person.zip) \(person.city), \(person.street)")
                            .font(.caption)
                        
                    }
                }
            }
            .navigationTitle("Contacts")
            .navigationBarItems(leading:
                Button(action: {
                    isAddPersonViewActive = true
                })
                {Image(systemName: "plus.circle.fill")},
                trailing: Button(action: {
                    //löschen
                })
                {Text("Edit")}
            )
        }
        .sheet(isPresented: $isAddPersonViewActive, content: {
            AddPersonView(viewModel: viewModel)
        })
        .environmentObject(viewModel)
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
