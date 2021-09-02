//
//  addFuncViewController.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 16.06.2021.
//
import RealmSwift
import UIKit

class addFuncViewController: UIViewController, UITextFieldDelegate {
   // let model = ToDoList()
    private let realm = try! Realm()
    

    @IBOutlet weak var text: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.delegate = self
        
    }
    
    
//    @IBAction func didTapSaveButton(_ sender: Any) {
//        if let text = text.text, !text.isEmpty {
//            model.title = text
//        }
//    }
}
