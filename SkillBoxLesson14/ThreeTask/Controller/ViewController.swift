//
//  ViewController.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 19.06.2021.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {
    let realm = try! Realm()
    @IBOutlet weak var Table: UITableView!
    @IBAction func addButton(_ sender: Any) {
        addAlert()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Table.dataSource = self
        Table.delegate = self
        toDoListArray = realm.objects(ToDoListItem.self)
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
            addTitle(text: text)
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
        return toDoListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = toDoListArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.date
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
    
        let action = UIContextualAction(style: .destructive, title: "Delete") { [self] _,_,_  in
            delTitle(indexPath: indexPath)
            Table.reloadData()
        }
        action.backgroundColor = .red
        return action
    }
}
