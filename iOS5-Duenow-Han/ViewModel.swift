//
//  ViewModel.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private var model = AddressBook.addressBook(fromFile: "book.json") ?? AddressBook()
    
    func updateViews() {
        objectWillChange.send()
    }
    
    var members: [AddressCard] {
        get {
            model.save(toFile: "book.json")
            return model.addressCards
        }
        set {
            model.addressCards = newValue
            model.save(toFile: "book.json")
        }
    }
}
