//
//  TrendCollectionViewCell.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/10.
//

import UIKit

class TrendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    // 변경되지 않는 UI
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
