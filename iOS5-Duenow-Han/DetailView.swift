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
    //@State var person: Person
    @State private var testName1: String = "ABC"
    @State private var testName2: String = "DEF"
   

    
    var body: some View {
        VStack {
            //TextField("name", text: $person.name)
            TextField("name", text: $testName1)
            TextField("name", text: $testName2)
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
