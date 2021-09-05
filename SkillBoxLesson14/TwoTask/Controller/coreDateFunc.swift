//
//  coreDateFunc.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 04.09.2021.
//

import Foundation
import UIKit
import CoreData

class tableCoreData {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveItems() {
        do{
        try context.save()
        } catch {
            print("Error")
        }
    }
    
    func dateString () -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        let dateString = formatter.string(from: date)
        return dateString
    }

    func addItem (name: String) {
        let newItems = Items(context: self.context)
        newItems.name = name
        newItems.dataCreate = dateString()
        newItems.isDone = false
        items.append(newItems)
    }
    
    func loadItems() {
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        items = try! context.fetch(request)
        print("Заметка загружена")
    }
    
    func delete(indexPath: IndexPath) {
        let item = items[indexPath.row]
        items.remove(at: indexPath.row)
        context.delete(item)
    }
    
    func state(indexPath: IndexPath) {
        let item = items[indexPath.row]
        item.isDone = !item.isDone
    }
}
