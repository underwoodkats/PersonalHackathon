//
//  GoalsViewCell.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2020/12/26.
//

import UIKit

class GoalCell: UITableViewCell {

    // TODO: We need to think how user can correct the goals
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalInProcessImage: UIImageView!
    @IBOutlet weak var goalCompletedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        goalInProcessImage.isHidden = true
        goalCompletedImage.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // One of the idea is
    }
}
