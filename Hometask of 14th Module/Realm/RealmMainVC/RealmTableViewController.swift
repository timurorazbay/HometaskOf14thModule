//
//  RealmTableViewController.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 17.04.2021.
//

import UIKit
import RealmSwift

class RealmTableViewController: UITableViewController {
    
    private let realm = try! Realm()
    var tasks: Results<Task>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        tasks = realm.objects(Task.self)
    }
    
//    MARK: - Реализация обработки нажатия кнопки Save
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let vc = segue.source as! RealmNewTableViewController
        
        let task = Task()
        task.taskName = vc.taskNameTextField.text ?? "nil"
        task.taskDescription = vc.taskDescriptionTextField.text ?? "nil"
        
        try! realm.write {
            realm.add(task)
        }
        
        self.tableView.insertRows(at: [IndexPath.init(row: tasks.count - 1, section: 0)], with: .fade)
    }

//    MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RealmTableViewCell
        let model = tasks[indexPath.row]
        // Configure the cell...
        cell.taskNameLabel.text = model.taskName
        cell.taskDescriptionLabel.text = model.taskDescription
        return cell
    }
    
//    MARK: - Анимированная обработка нажатия на ячейку
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    MARK: - Реализация удаления ячейки из таблицы
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let deletingRow = tasks[indexPath.row]
            try! self.realm.write {
                self.realm.delete(deletingRow)
                self.tableView.reloadData()
            }
        }
    }
}
