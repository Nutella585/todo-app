//
//  TaskTableViewCell.swift
//  todo-app
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskImgView      : UIImageView!
    @IBOutlet weak var headerTextLbl    : UILabel!
    @IBOutlet weak var descriptionTextLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
