//
//  TasksVC.swift
//  todo-app
//

import UIKit

class TasksVC: UITableViewController {
    
    var tasks: Array<Job> = [
        Job(
            name: "Example #1",
            description: "This is an example of the description of Job struct.",
            isImportant: false
        ),
        Job(
            name: "Example #2",
            description: "This is an example of the description of Job struct.",
            isImportant: false
        ),
        Job(
            name: "Example #3",
            description: "This is an example of the description of Job struct.",
            isImportant: false
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Shows title on top of the current ViewControllers screen
        self.title = "Your Todos"
        
        // Display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // Actions when segue unwind is performed
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == Identifiers.SAVE_SEGUE.rawValue else { return }
        let sourceVC = segue.source as! NewTaskVC
        let task = sourceVC.task
        
        // For editing task
        if let selectedCellIndexPath = tableView.indexPathForSelectedRow {
            tasks[selectedCellIndexPath.row] = task
            tableView.reloadRows(at: [selectedCellIndexPath], with: .automatic)
        }
        // For adding new task
        else {
            let indexPath = IndexPath(row: tasks.count, section: 0)
            tasks.append(task)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Prepare `NewTaskVC` for editting with the values from the cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == Identifiers.EDIT_SEGUE.rawValue else { return }
        
        let indexPath = tableView.indexPathForSelectedRow?.row
        let choosenTask = self.tasks[indexPath!]
        
        let navigationVC = segue.destination as! UINavigationController
        let editVC = navigationVC.topViewController as! NewTaskVC
        
        editVC.title = "Edit task"
        editVC.task = choosenTask
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.CELL.rawValue, for: indexPath) as! TaskTableViewCell
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
    
    // ------------------------------
    // MARK: - Cell swiping actions
    // ------------------------------
    
    // Actions for the leading side of the cell
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actions: Array<UIContextualAction> = [
            doneAction(for: indexPath),
            importantAction(for: indexPath)
        ]
        
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    // Action "Done"
    func doneAction (for indexPath :IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done", handler: {  action , view, completition in
            self.tasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completition(true)
        })
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: SystemIcons.CHECKMARK.rawValue)
        
        return action
    }
    
    // Action "Important"
    func importantAction (for indexPath :IndexPath) -> UIContextualAction {
        var task = tasks[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Important", handler: {  action , view, completition in
            task.isImportant = task.isImportant ? false : true
            self.tasks[indexPath.row] = task
            completition(true)
        })
        action.backgroundColor  = task.isImportant ? .systemYellow : .systemGray
        action.image            = task.isImportant ? UIImage(systemName: SystemIcons.WARNING_FILL.rawValue) :
                                                     UIImage(systemName: SystemIcons.WARNING.rawValue)
        
        return action
    }
}
