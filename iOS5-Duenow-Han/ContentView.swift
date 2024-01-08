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
    @State private var selectedCards: [UUID: Bool] = [:]
    
    var body: some View {
        NavigationView {
            List(selection: $viewModel.selectedCards) {
                ForEach(viewModel.members) { person in
                    NavigationLink(destination: DetailView(person: person)){
                        VStack(alignment: .leading) {
                            Text("\(person.firstName) \(person.lastName)")
                                .font(.headline)
                            Text("\(String(person.zip)) \(person.city), \(person.street)")
                                .font(.caption)
                            
                        }
                    }
                    
                }
                .onDelete { indexSet in
                    viewModel.deleteSelectedCards(at: indexSet)
                }
            }
            
            .navigationTitle("Contacts")
            .navigationBarItems(
                leading: Button(action: {
                    isAddPersonViewActive = true
                }) {
                    Image(systemName: "plus.circle.fill")
                },
                trailing: EditButton()
            )
            
        }
        .environmentObject(viewModel)
        .sheet(isPresented: $isAddPersonViewActive, content: {
            AddPersonView(viewModel: viewModel)
        })
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
