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
    @State var person: Person
    
    var body: some View {
        Vstack {
            TextField("name", text: $person.name)
        }
        .navigationTitle("Title")
        .onDisappear {
            viewModel.updateViews()
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
