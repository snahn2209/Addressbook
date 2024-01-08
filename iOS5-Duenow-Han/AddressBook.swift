//
//  AddressBook.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation

let FILE_NAME = "book.json"

class AddressBook: Codable {
    var addressCards: [AddressCard]
    
    init() {
        addressCards = []
        // Load data from JSON file
        if let loadedAddressBook = AddressBook.load(fromFile: FILE_NAME) {
            addressCards = loadedAddressBook.addressCards
        }
        //self.saveExampleCards()
        //self.saveToFile()
    }
    
    //for testing
    func saveExampleCards(){
        addressCards.append(AddressCard(firstName: "Ricards", lastName: "Bauernfeind", street: "Hochstraße", zip: 12345, city: "Ingolstadt", friends: [AddressCard.ID]()))
        addressCards.append(AddressCard(firstName: "Demi", lastName: "Vollering", street: "Bergstraße", zip: 12345, city: "Maastricht", friends: [AddressCard.ID]()))
        addressCards.append(AddressCard(firstName: "Jonas", lastName: "Vingegaard", street: "Seestraße", zip: 12345, city: "Berlin", friends: [AddressCard.ID]()))
    }
    
    class func load(fromFile filename: String) -> AddressBook? {
        do {
            let documentDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentDirectoryURL.appendingPathComponent(filename)

            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let addressBook = try decoder.decode(AddressBook.self, from: data)
            print("Data loaded successfully from: \(fileURL.path)")

            return addressBook
        } catch {
            print("Error loading data: \(error)")
            return nil
        }
    }
    
    func saveToFile(){
        do {
            let documentDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectoryURL.appendingPathComponent(FILE_NAME)

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // optional for pretty-printed JSON

            let data = try encoder.encode(self)
            try data.write(to: fileURL)

            print("Data saved successfully to: \(fileURL.path)")
        } catch {
            print("Error saving data: \(error)")
        }
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
    
    func deleteCards(withIDs cardIDs: [UUID]) {
        addressCards.removeAll { cardIDs.contains($0.id) }
        for friendCards in addressCards {
            friendCards.friendIDs.removeAll { cardIDs.contains($0) }
        }
        saveToFile()
    }
}

