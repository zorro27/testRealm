//
//  weatherLoader.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 23.06.2021.
//

import Foundation
import RealmSwift

protocol weatherDelegate {
    func saveWeather (temp: Double, wind: Double)
}

var city = "Moscow"
var apiKey = "df20d04763777b12725acd6f5cb77517"
var urlString = "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&units=metric&appid=" + apiKey

class weatherLoader {
    let realm = try! Realm()
    var delegate: weatherDelegate?
    
    func loadWeather () {
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [self] (data, responce, error) in
            do {
                if let dataStr = data {
                let json: [String : AnyObject] = try JSONSerialization.jsonObject(with: dataStr, options: .mutableContainers) as! [String : AnyObject]
                let a = pars(json: json)
                DispatchQueue.main.async {
                    self.delegate?.saveWeather(temp: a.temp, wind: a.wind)
                }
            }
        }
            catch {
                print("Error")
            }
        }
        task.resume()
    }
}

func pars(json: [String : AnyObject]) -> (temp: Double, wind: Double) {
    var temp1: Double = 0.0
    var wind1: Double = 0
    if let temp = json ["main"] {
        temp1 = temp["temp"] as! Double
    }
    if let wind = json ["wind"] {
        wind1 = wind["speed"] as! Double
    }
    print("Данные распарсил")
    return (temp: temp1, wind: wind1)
}
