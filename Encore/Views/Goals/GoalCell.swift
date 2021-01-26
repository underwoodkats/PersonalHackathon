//
//  GoalsViewCell.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import UIKit

class GoalCell: UITableViewCell {

    // TODO: Level 1 - We need to think how user can correct the goals
    
    weak var delegate: GoalCellDelegate?
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalInProcessImage: UIImageView!
    @IBOutlet weak var goalCompletedImage: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        goalInProcessImage.isHidden = true
        goalCompletedImage.isHidden = true
        removeButton.isHidden = true
    }
    
    @IBAction func removePressed(_ sender: UIButton) {
        guard let delegate = self.delegate else { return }
        delegate.didPressRemoveButton(self)
    }
}

protocol GoalCellDelegate: class {
    func didPressRemoveButton(_ cell: UITableViewCell)
}
