//
//  ViewModel.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private var model: AddressBook = AddressBook()
    @Published var selectedCards: Set<UUID> = Set()
    
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
    func deleteSelectedCards(at indices: IndexSet) {
        let selectedIDs = indices.map { members[$0].id }
        model.deleteCards(withIDs: selectedIDs)
        selectedCards = Set() // Clear the selection after deletion
        updateViews()
    }

    
}
