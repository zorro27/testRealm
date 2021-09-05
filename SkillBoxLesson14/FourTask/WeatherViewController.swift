//
//  WeatherViewController.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 23.06.2021.
//

import UIKit

class WeatherViewController: UIViewController, weatherDelegate{
    func saveWeather(temp: Double, wind: Double) {
        let save = funcRealm()
        save.saveWeather(temp: temp, wind: wind)
    }
    
    var delegate: weatherDelegate?
    
    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CityNameLabel.text = city
        let loader = weatherLoader()
        loader.delegate = self
        resultWeather()
    }
    
    func  resultWeather(){
        let result = funcRealm()
        let data = result.resultWeather()
        self.tempLabel.text = "Температура - " + String(((data.temp ?? 0.0 * 10).rounded())) + "ºC"
        self.windLabel.text = "Сила ветра - " + String(data.wind ?? 0.0) + "м/с"
        print("Данные распечатал из базы данных")
    }
}
