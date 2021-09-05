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

class funcRealm {
    let realm = try! Realm()
    func saveWeather(temp: Double, wind: Double) {
        let weather = weather()
        weather.temp = temp
        weather.speed = wind
        realm.beginWrite()
        realm.add(weather)
        print("Данные сохранил в Реалм")
        try! realm.commitWrite()
    }
    
    func resultWeather()->(temp: Double, wind: Double) {
        let result = realm.objects(weather.self)
        let element = result.last
        let temp = element?.temp ?? 0.0
        let wind = element?.speed ?? 0.0
        return (temp, wind)
    }
}
