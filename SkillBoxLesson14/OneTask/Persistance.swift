//
//  Persistance.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 10.04.2021.
//

import Foundation

class Persistanse {
    static let shared = Persistanse()
    
    var nameKey = "Persistanse.nameKey"
    var surnameKey = "Persistanse.surnameKey"
    
    var nameUser: String {
        set {UserDefaults.standard.set(newValue, forKey: nameKey)}
        get {return UserDefaults.standard.string(forKey: nameKey) ?? ""}
    }
    var surnameUser: String {
        set {UserDefaults.standard.set(newValue, forKey: surnameKey)}
        get {return UserDefaults.standard.string(forKey: surnameKey) ?? ""}
        
    }
    
}
