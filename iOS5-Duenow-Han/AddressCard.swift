//
//  AddressCard.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation

class AddressCard: Identifiable, Codable, Equatable, Hashable {
    
    var id: UUID
    var firstName: String
    var lastName: String
    var street: String
    var zip: Int
    var city: String
    var hobbies = [Hobby]()
    var friendIDs = [UUID]()
    
    init(firstName: String, lastName: String, street: String, zip: Int, city: String, hobbies: [Hobby], friends: [AddressCard.ID]) {
        id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.zip = zip
        self.city = city
        self.hobbies = hobbies
        self.friendIDs = friends
    }
    
    //init without hobbies
    init(firstName: String, lastName: String, street: String, zip: Int, city: String, friends: [AddressCard.ID]) {
        id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.zip = zip
        self.city = city
        self.hobbies = [Hobby]()
        self.friendIDs = friends
    }
    
    static func == (lhs: AddressCard, rhs: AddressCard) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    func add(hobby: Hobby) {
        hobbies.append(hobby)
    }
    func remove(hobby:Hobby) {
        if let index = hobbies.firstIndex(of: hobby) {
            hobbies.remove(at: index)
        }
    }
    func remove(hobbyName: String) {
        if let index = hobbies.firstIndex(where: {$0.name == hobbyName}) {
            hobbies.remove(at: index)
        }
    }
    func add(friend: AddressCard) {
        friendIDs.append(friend.id)
    }
    func remove(friend: AddressCard) {
        if let index = friendIDs.firstIndex(of: friend.id) {
            friendIDs.remove(at: index)
        }
    }
    
    func printCard (addressBook: AddressBook){
            let friends = addressBook.friendsOf(card: self)
            
            let cardTemplate = """
                    +-----------------------------------
                    | \(firstName) \(lastName)
                    | \(street)
                    | \(zip) \(city)
                    | Hobbies:
                    \(hobbies.map { "|   \($0.name)" }.joined(separator: "\n"))
                    | Friends:
                    \(friends.map { "|   \($0.firstName) \($0.lastName), \($0.zip) \($0.city)" }.joined(separator: "\n"))
                    +-----------------------------------
                    """
            print(cardTemplate)
        }
    
}

