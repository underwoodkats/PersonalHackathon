//
//  ScheduleViewCell.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import UIKit

class ScheduleCell: UITableViewCell {

    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var backgroundGradientView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setGradientView()
    }

    func setGradientView() {
        // TODO: Implement gradient
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
