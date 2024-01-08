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
                        NavigationLink(destination: DetailView(viewModel: viewModel, person: person)){
                            Text("\(person.firstName) \(person.lastName)")
                        }
                    }
                }
            }
            .navigationTitle("Addressbook")
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
