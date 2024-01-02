//
//  ContentView.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.members){ person in
                        NavigationLink(destination: DetailView(person: person)){
                            Text("\(person.firstName) \(person.lastName)")
                        }
                    }
                }
            }
            .navigationTitle("Addressbook")
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
