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
            return model.addressCards
        }
        set {
            model.addressCards = newValue
            model.saveToFile()
            
        }
    }
    

    func findAddressCard(by id: UUID) -> AddressCard? {
        model.findAddressCard(by: id)
    }
    
    func remove(addressCard: AddressCard){
        model.remove(addressCard: addressCard)
        updateViews()
    }
    
    func changeCard(cardID: UUID, changedCard: AddressCard){
        model.changeCard(cardID: cardID, changedCard: changedCard)
        updateViews()
    }
    
}
