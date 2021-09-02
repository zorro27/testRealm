//
//  CoreData.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 10.04.2021.
//

import UIKit
import CoreData

class CoreDataTask: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Table: UITableView!

    var items = [Items]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        Table.delegate = self
        Table.dataSource = self
        loadItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.dataCreate
        return cell
        }

    
    @IBAction func addButton(_ sender: Any) {
        var alertTF: UITextField!
        let alert = UIAlertController(title: "New Task", message: "Rite", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Save", style: .default) {(action) in
            let newItems = Items(context: self.context)
            newItems.name = alertTF.text!
            newItems.dataCreate = dateString()
            self.items.append(newItems)
            self.saveItems()
        }
        
        alert.addTextField {field in
            alertTF = field
            alertTF.placeholder = "newTask"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let item = items[indexPath.row]
            items.remove(at: indexPath.row)
            context.delete(item)

            do{
            try context.save()
            } catch {
                print("Error")
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
        self.Table.reloadData()
    }
    
    func saveItems() {
        do{
        try context.save()
        } catch {
            print("Error")
        }
        self.Table.reloadData()
    }
    
    func loadItems() {
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        items = try! context.fetch(request)
        self.Table.reloadData()
    }
}
