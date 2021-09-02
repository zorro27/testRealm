//
//  WeatherViewController.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 23.06.2021.
//

import UIKit
import RealmSwift

class WeatherViewController: UIViewController, weatherDelegate{
    func saveWeather(temp: Double, wind: Double) {
        let weather = weather()
        weather.temp = temp
        weather.speed = wind
        realm.beginWrite()
        realm.add(weather)
        print("Данные сохранил в Реалм")
        try! realm.commitWrite()
    }
    
    let realm = try! Realm()
    var delegate: weatherDelegate?
    
    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBAction func updateButton(_ sender: Any) {
        let loader = weatherLoader()
        loader.delegate = self
        loader.loadWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CityNameLabel.text = city
        resultWeather()
    }
    
    func  resultWeather(){
        let result = realm.objects(weather.self)
        let element = result.last
        self.tempLabel.text = "Температура - " + String(((element?.temp ?? 0.0 * 10).rounded())) + "ºC"
        self.windLabel.text = "Сила ветра - " + String(element?.speed ?? 0.0) + "м/с"
        print("Данные распечатал из базы данных")
        print(element?.speed)
        print(element?.temp)
    }
    
    
}
