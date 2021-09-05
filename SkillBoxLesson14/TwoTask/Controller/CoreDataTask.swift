//
//  CoreData.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 10.04.2021.
//

import UIKit
import CoreData

var items = [Items]()

class CoreDataTask: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Table: UITableView!

 
    var result = tableCoreData()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        Table.tableFooterView = UIView()
        Table.delegate = self
        Table.dataSource = self
        result.loadItems()
        self.Table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.dataCreate
        if item.isDone {
        cell.accessoryType = .checkmark
        cell.textLabel?.textColor = .systemGray4
        cell.detailTextLabel?.textColor = .systemGray4
        }else{
        cell.accessoryType = .none
        }
        return cell
        }

    
    @IBAction func addButton(_ sender: Any) {
        var alertTF: UITextField!
        let alert = UIAlertController(title: "New Task", message: "Rite", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Save", style: .default) {(action) in
            let nameItem = alertTF.text ?? "No name"
            self.result.addItem(name: nameItem)
            self.result.saveItems()
            self.Table.reloadData()
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
            result.delete(indexPath: indexPath)
            result.saveItems()
            tableView.deselectRow(at: indexPath, animated: true)
        }
        self.Table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        let state = tableCoreData()
        state.state(indexPath: indexPath)
        if item.isDone {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            Table.cellForRow(at: indexPath)?.textLabel?.textColor = .systemGray4
            Table.cellForRow(at: indexPath)?.detailTextLabel?.textColor = .systemGray4
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            Table.cellForRow(at: indexPath)?.textLabel?.textColor = .black
            Table.cellForRow(at: indexPath)?.detailTextLabel?.textColor = .black
        }
        result.saveItems()
    }
}
