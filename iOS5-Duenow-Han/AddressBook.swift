//
//  AddressBook.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation

class AddressBook: Codable {
    var addressCards: [AddressCard]
    
    init(addressCards: [AddressCard] ) {
            self.addressCards = addressCards
    }
    
    init() {
        self.addressCards = []
    }
    
    func add(addressCard: AddressCard) {
        addressCards.append(addressCard)
    }
    func remove(addressCard: AddressCard){
        if let index = addressCards.firstIndex(of: addressCard) {
            addressCards.remove(at: index)
        }
        // '$0' -> shorthand notation representing the first parameter of a closure expression
        for friendCards in addressCards {
            friendCards.friendIDs.removeAll{ $0 == addressCard.id }
        }
    }
    func sortByLastName(){
        self.addressCards.sort(by: { $0.lastName < $1.lastName })
    }
    
    func findAddressCard (by lastName: String) -> AddressCard? {
        self.addressCards.first(where: { $0.lastName == lastName })
    }
    
    func findAddressCard (by id: UUID) -> AddressCard? {
        self.addressCards.first(where: { $0.id == id })
    }
    
    func friendsOf(card: AddressCard) -> [AddressCard] {
        var friends = [AddressCard]()
        for friend in card.friendIDs {
            if let f = findAddressCard(by: friend)  {
                friends.append(f)
            }
        }
        return friends
    }
    
    func save(toFile path: String){
        // file for saving data
        let path = "book.json"
        let url = URL(fileURLWithPath: path)
        // encode and save
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self) {
            try? data.write(to: url)
        }
    }
    
    class func addressBook(fromFile path: String) -> AddressBook? {
        let url = URL(fileURLWithPath: path)
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            let addressBook = try? decoder.decode(AddressBook.self, from: data)
            return addressBook
        }
        return AddressBook()
    }
    func deleteCard(addressCard: AddressCard){
        //delte as a friend
        for c in self.addressCards{
            c.friendIDs = c.friendIDs.filter{$0 != addressCard.id}
        }
        
        //delete card itself
        self.remove(addressCard: addressCard)
    }

}

