//
//  weatherSave.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 31.08.2021.
//

import Foundation
import RealmSwift

class weather: Object {
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var speed: Double = 0.0
}
