//
//  OverViewTableViewCell.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/08.
//

import UIKit

class OverViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configureCell(overview: String) {
        overviewLabel.text = overview
    }
}
