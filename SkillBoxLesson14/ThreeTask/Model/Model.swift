//
//  Model.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 18.06.2021.
//

import Foundation
import RealmSwift

class ToDoListItem: Object {
    @objc dynamic var title = ""
    @objc dynamic var date = ""
}
let realm = try! Realm()
var toDoListArray: Results<ToDoListItem>!

func dateString () -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy HH:mm"
    let dateString = formatter.string(from: date)
    return dateString
}

func addTitle(text: String) {
    let task = ToDoListItem()
    task.title = text
    task.date = dateString()
    try! realm.write {
         realm.add(task)
    }
}

func delTitle (indexPath: IndexPath) {
    let editingRow = toDoListArray[indexPath.row]
    try! realm.write{
         realm.delete(editingRow)
    }
}
