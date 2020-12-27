//
//  GoalsViewCell.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2020/12/26.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // TODO: We need to think how user can correct the goals
        // One of the idea is
    }
}
