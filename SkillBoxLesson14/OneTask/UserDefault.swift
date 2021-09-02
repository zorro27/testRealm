//
//  UserDefaults.swift
//  SkillBoxLesson14
//
//  Created by Роман Зобнин on 10.04.2021.
//

import UIKit

class UserDefault: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.addTarget(self, action: #selector(UserDefault.add(textField:)), for: UIControl.Event.editingChanged)
        surnameTF.addTarget(self, action: #selector(UserDefault.add(textField:)), for: UIControl.Event.editingChanged)
        nameTF.text = Persistanse.shared.nameUser
        surnameTF.text = Persistanse.shared.surnameUser
    }
    
    @objc func add (textField: UITextField) {
        Persistanse.shared.nameUser = nameTF.text ?? "Error"
        Persistanse.shared.surnameUser = surnameTF.text ?? "Error"
    }
}
