//
//  GoalsViewCell.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import UIKit

class GoalCell: UITableViewCell {

    // TODO: Level 1 - We need to think how user can correct the goals
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalInProcessImage: UIImageView!
    @IBOutlet weak var goalCompletedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        goalInProcessImage.isHidden = true
        goalCompletedImage.isHidden = true
    }
}
