//
//  ViewModel.swift
//  iOS5-Duenow-Han
//
//  Created by Sina Han on 12.12.23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private var model = Members()
    
    func updateViews() {
        objectWillChange.send()
    }
    
    var members: [Person] {
        get {
            model.members
        }
        set {
            model.members = newValue
        }
    }
}
