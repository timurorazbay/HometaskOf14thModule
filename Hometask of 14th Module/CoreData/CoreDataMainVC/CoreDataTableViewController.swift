//
//  CoreDataTableViewController.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 18.04.2021.
//

import UIKit

class CoreDataTableViewController: UITableViewController {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [CoreDataTask]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

         self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        fetchTasks()
    }
    
    func fetchTasks() {
        do {
            tasks = try context.fetch(CoreDataTask.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
//    MARK: - Реализация обработки нажатия кнопки Save
    
    @IBAction func unwindSegueCoreData(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let vc = segue.source as! CoreDataNewTableViewController
        
        let task = CoreDataTask(context: context)
        task.taskName = vc.taskNameTextField.text
        task.taskDescpription = vc.taskDescriptionTextField.text
        
        try! self.context.save()
        
        fetchTasks()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoreDataTableViewCell
        let model = self.tasks![indexPath.row]
        // Configure the cell...
        cell.taskNameLabel.text = model.taskName
        cell.taskDescriptionLabel.text = model.taskDescpription
        return cell
    }
    
//    MARK: - Реализация удаления ячейки
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletingRow = tasks![indexPath.row]
            
            self.context.delete(deletingRow)
            try! self.context.save()
            
            fetchTasks()
        }
    }
}
