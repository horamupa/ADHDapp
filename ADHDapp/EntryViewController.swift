//
//  EntryViewController.swift
//  ADHDapp
//
//  Created by MM on 27.06.2022.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textfield: UITextField!
    
    var update: (()-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        

        // Do any additional setup af ter loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        
        return true
    }
    
    @objc func saveTask() {
        
        guard let task = textfield.text, !task.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(task, forKey: "task_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
        
    }

}
