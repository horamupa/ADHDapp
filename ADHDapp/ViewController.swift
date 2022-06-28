//
//  ViewController.swift
//  ADHDapp
//
//  Created by MM on 27.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    func updateTask() {
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for i in (0..<count) {
            if let task = UserDefaults().value(forKey: "task_\(i + 1)") as? String {
                tasks.append(task)
            }
        }
        
        self.tableView.reloadData()
        }
        
    
    
    @IBAction func didTapAdd(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "Entry") as! EntryViewController
        vc.title = "New task"
        navigationController?.pushViewController(vc, animated: true)
        vc.update = {
            DispatchQueue.main.async {
                self.updateTask()
            }
            
        }
        
    }
    
    
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        // Do any additional setup after loading the view.
        updateTask()
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
}


