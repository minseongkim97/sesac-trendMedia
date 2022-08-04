//
//  SearchCollectionViewCell.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/04.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "SearchCollectionViewCell"

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var clipButton: UIButton!
    
    //MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAttribute()
    }

    //MARK: - Helpers
    private func configureAttribute() {
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor.label.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        infoView.layer.cornerRadius = 8
        
        clipButton.layer.cornerRadius = clipButton.frame.width / 2
    }
}
