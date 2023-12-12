//
//  Hobby.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation

class Hobby: Identifiable, Codable, Equatable {
    static func == (lhs: Hobby, rhs: Hobby) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var name: String = ""
    
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
    
}

