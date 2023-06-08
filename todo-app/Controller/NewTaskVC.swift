//
//  NewTaskVC.swift
//  todo-app
//
//  Created by Andriy Pylo on 08.06.2023.
//

import UIKit

class NewTaskVC: UITableViewController {

    @IBOutlet weak var nameTxtField         : UITextField!
    @IBOutlet weak var descriptionTxtField  : UITextField!
    @IBOutlet weak var isImportantSwitch    : UISwitch!
    
    @IBOutlet weak var saveBtn              : UIBarButtonItem!
    
    var task = Job(
        image: UIImage(systemName: "record.circle")!, //  ---- ! ---
        name: "",
        description: "",
        isImportant: false
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create new Todo"
        saveBtn.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        
        task.name = nameTxtField.text ?? ""
        task.description = descriptionTxtField.text ?? ""
        task.isImportant = isImportantSwitch.isEnabled
        
        print(self.task)
        
    }
    
    // Check for UITextFields values
    @IBAction func txtFieldChanged(_ sender: UITextField) {
        updateSaveBtnState()
    }
    
    // Update "Save" button
    private func updateSaveBtnState () {
        let name = nameTxtField.text ?? ""
        let description = descriptionTxtField.text ?? ""
        
        saveBtn.isEnabled = !name.isEmpty && !description.isEmpty
    }
}
