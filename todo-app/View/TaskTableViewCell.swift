//
//  TaskTableViewCell.swift
//  todo-app
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskImgView        : UIImageView!
    @IBOutlet weak var headerTextLbl      : UILabel!
    @IBOutlet weak var descriptionTextLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // Set properties of the model object `Job` to cells `TaskTableViewCell`
    func set(task: Job){
        self.taskImgView.image = task.image
        self.headerTextLbl.text = task.name
        self.descriptionTextLbl.text = task.description
    }
}
