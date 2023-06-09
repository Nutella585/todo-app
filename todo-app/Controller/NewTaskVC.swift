//
//  NewTaskVC.swift
//  todo-app
//

import UIKit

class NewTaskVC: UITableViewController {

    @IBOutlet weak var nameTxtField         : UITextField!
    @IBOutlet weak var descriptionTxtField  : UITextField!
    @IBOutlet weak var isImportantSwitch    : UISwitch!
    
    @IBOutlet weak var circleIconCheckmark      : UIImageView!
    @IBOutlet weak var importantIconCheckmark   : UIImageView!
    @IBOutlet weak var favouriteIconCheckmark   : UIImageView!
    
    @IBOutlet weak var saveBtn              : UIBarButtonItem!
    
    var task = Job(
        name: "",
        description: "",
        isImportant: false
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSaveBtnState()
        showValuesForEditing()
        
        circleIconCheckmark.isHidden    = true
        importantIconCheckmark.isHidden = true
        favouriteIconCheckmark.isHidden = true
        
        self.title = "Create new Todo"
    }
    
    // ------------------------------
    // MARK: - Table view inherrited
    // ------------------------------
    
    // If `UITextField` is changed, update "Save" button.
    @IBAction func txtFieldChanged(_ sender: UITextField) {
        updateSaveBtnState()
    }
    
    // If `UISwitch is` changed, update "Save" button.
    @IBAction func switchChanged (_ sender: UISwitch) {
        updateSaveBtnState()
    }
    
    // Update checkmarks for what kind of checkmark is choosen
    // If cell with diffrnt icon was used, update "Save" button.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateSaveBtnState()
    }
    
    // Prepare data for segue back to `TaskVC`
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == Identifiers.SAVE_SEGUE.rawValue else { return }
        
        task.name = nameTxtField.text ?? ""
        task.description = descriptionTxtField.text ?? ""
        task.isImportant = isImportantSwitch.isOn
    }
    
    // ------------------------------
    // MARK: - Custom functions
    // ------------------------------
    
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
        let currentImage = task.image
        
        if let choosenCellIndexPath = tableView.indexPathForSelectedRow {
            updateIcons(indexPath: choosenCellIndexPath)
        }
        
        let newImage = task.image
        
        saveBtn.isEnabled = (!name.isEmpty && !description.isEmpty) || currentImage != newImage
    }
    
    // Update icons in "Icons" section
    private func updateIcons (indexPath: IndexPath) {
        switch indexPath {
        case [3, 0]: // "Circle" icon
            circleIconCheckmark.isHidden    = false
            importantIconCheckmark.isHidden = true
            favouriteIconCheckmark.isHidden = true
            
            self.task.image = UIImage(systemName: SystemIcons.CIRCLE.rawValue)
            
        case [3, 1]: // "Important" icon
            circleIconCheckmark.isHidden    = true
            importantIconCheckmark.isHidden = false
            favouriteIconCheckmark.isHidden = true
            
            task.image = UIImage(systemName: SystemIcons.IMPORTANT.rawValue)
            
        case [3, 2]: // "Favourite" icon
            circleIconCheckmark.isHidden    = true
            importantIconCheckmark.isHidden = true
            favouriteIconCheckmark.isHidden = false
            
            self.task.image = UIImage(systemName: SystemIcons.HEART.rawValue)
            
        default:  return
        }
    }
}
