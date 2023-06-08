//
//  NewTaskVC.swift
//  todo-app
//

import UIKit

class NewTaskVC: UITableViewController {

    @IBOutlet weak var nameTxtField         : UITextField!
    @IBOutlet weak var descriptionTxtField  : UITextField!
    @IBOutlet weak var isImportantSwitch    : UISwitch!
    
    @IBOutlet weak var saveBtn              : UIBarButtonItem!
    
    var task = Job(
        name: "",
        description: "",
        isImportant: false
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create new Todo"
        updateSaveBtnState()
        showValuesForEditing()
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == Identifiers.SAVE_SEGUE.rawValue else { return }
        
        task.name = nameTxtField.text ?? ""
        task.description = descriptionTxtField.text ?? ""
        task.isImportant = isImportantSwitch.isOn
    }
    
    // Show values from existing cell
    private func showValuesForEditing () {
        nameTxtField.text = task.name
        descriptionTxtField.text = task.description
        isImportantSwitch.isOn = task.isImportant
    }

    // Update "Save" button
    private func updateSaveBtnState () {
        let name = nameTxtField.text ?? ""
        let description = descriptionTxtField.text ?? ""
        
        saveBtn.isEnabled = !name.isEmpty && !description.isEmpty
    }

    // Check for UITextFields values
    @IBAction func txtFieldChanged(_ sender: UITextField) {
        updateSaveBtnState()
    }
}
