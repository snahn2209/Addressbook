//
//  ViewModel.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private var model: AddressBook = AddressBook()
    @Published private var selectedCards: [UUID: Bool] = [:]
    
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
    func deleteSelectedCards() {
        let selectedIDs = selectedCards.filter { $0.value }.map { $0.key }
        for id in selectedIDs {
            if let cardToRemove = members.first(where: { $0.id == id }) {
                model.remove(addressCard: cardToRemove)
            }
        }
        updateViews()
    }

    func toggleSelected(card: AddressCard) {
        selectedCards[card.id]?.toggle()
    }
}
