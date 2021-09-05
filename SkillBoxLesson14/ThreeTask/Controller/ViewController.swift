//
//  ViewController.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 19.06.2021.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var Table: UITableView!
    @IBAction func addButton(_ sender: Any) {
        addAlert()
    }
    var tableResult = tableRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Table.tableFooterView = UIView()
        Table.dataSource = self
        Table.delegate = self
        self.tableResult.presentTable()
    }
    
    func addAlert() {
        let alert = UIAlertController(title: "Новая задача", message: "Пиши", preferredStyle: .alert)
        
        var alertTF: UITextField!
        alert.addTextField { textField in
            alertTF = textField
            textField.placeholder = "Новая задача"
        }
        let save = UIAlertAction(title: "Save", style: .default) {action in
            guard let text = alertTF.text, !text.isEmpty else {return}
            self.tableResult.addTitle(text: text)
            self.Table.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Сancel", style: .cancel, handler: nil)
        alert.addAction(save)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableResult.toDoListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = tableResult.toDoListArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.date
        if item.done {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .systemGray4
            cell.detailTextLabel?.textColor = .systemGray4
        }else {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [self] _,_,_  in
            tableResult.delTitle(indexPath: indexPath)
            Table.reloadData()
        }
        action.backgroundColor = .red
        return action
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = tableResult.toDoListArray[indexPath.row]
        
        if item.done == true {
            item.done = false
            
        } else {
            item.done = true
        }
        tableResult.save(indexPath: indexPath)
    }
}
