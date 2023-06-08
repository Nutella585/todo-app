//
//  TasksVC.swift
//  todo-app
//

import UIKit

class TasksVC: UITableViewController {
    
    var tasks: Array<Job> = [
        Job(
            image: UIImage(systemName: "record.circle")!, //  ---- ! ---
            name: "Example #1",
            description: "This is an example of the description of Job struct.",
            isDone: false
        ),
        Job(
            image: UIImage(systemName: "record.circle")!, //  ---- ! ---
            name: "Example #2",
            description: "This is an example of the description of Job struct.",
            isDone: false
        ),
        Job(
            image: UIImage(systemName: "record.circle")!, //  ---- ! ---
            name: "Example #3",
            description: "This is an example of the description of Job struct.",
            isDone: false
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Shows title on top of the current ViewControllers screen
        self.title = "Your Todos"
        
        // Display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // ------------------------------
    // MARK: - Table view data source
    // ------------------------------
    
    // Section number
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    // Row appearance
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]
        cell.set(task: task)
        
        return cell
    }
    
    // ------------------------------
    // MARK: - Editing cells in section
    // ------------------------------
    
    // Editing style for cells when "Edit" button is pressed on `NavigationViewController`
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Actions if cell is deleted
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // ------------------------------
    // MARK: - Moving cells in section
    // ------------------------------
    
    // Is cells are movable.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Move cell to other row.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedTask = tasks.remove(at: sourceIndexPath.row)
        tasks.insert(movedTask, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
}
