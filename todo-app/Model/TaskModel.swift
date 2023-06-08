//
//  TaskModel.swift
//  todo-app
//

import Foundation
import UIKit


/**
 The keyword "`Task`" is reserved by the in-built Swift library. Using `Job` instead.
 */
struct Job {
    /// Image that show on the left side of the `UITableViewCell`.
    var image       : UIImage!
    var name        : String
    var description : String
    var isImportant : Bool
}
