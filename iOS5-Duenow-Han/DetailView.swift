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
        VStack {
            Text("\(person.firstName) \(person.lastName)")
        }
        .navigationTitle("\(person.firstName) \(person.lastName)")
        .onDisappear {
            viewModel.updateViews()
        }
    }
}

#Preview {
    NavigationView{DetailView(person: AddressCard(firstName: "Laura", lastName: "Müller", street: "Straße", zip: 12345, city: "Berlin", friends: [AddressCard.ID]()))}
}
