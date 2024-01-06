//
//  ViewModel.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private var model: AddressBook = AddressBook()
    
    func updateViews() {
        objectWillChange.send()
    }
    
    var members: [AddressCard] {
        get {
            model.sortByLastName()
            return model.addressCards
        }
        set {
            model.addressCards = newValue
            model.saveToFile()
        }
    }
    func addCard(newContact: AddressCard) {
        model.add(addressCard: newContact)
        updateViews()
    }
}
