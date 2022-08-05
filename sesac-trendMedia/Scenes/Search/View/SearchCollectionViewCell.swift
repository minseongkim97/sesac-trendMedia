//
//  SearchCollectionViewCell.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/04.
//

import UIKit

import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var clipButton: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
    //MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAttribute()
    }

    //MARK: - Helpers
    private func configureAttribute() {
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOffset = .zero
        
        infoView.layer.cornerRadius = 8
        
        clipButton.layer.cornerRadius = clipButton.frame.width / 2
    }
    
    func configureCell(tv: TV) {
        releaseDateLabel.text = tv.releaseDate.date.text
        genresLabel.text = tv.genres.joined(separator:" ")
        rateLabel.text = String(format: "%.1f", tv.average)
        titleLabel.text = tv.title
        actorsLabel.text = tv.actor.joined(separator: ", ")
        posterImageView.kf.setImage(with: URL(string: EndPoint.imagePath + (tv.thumbnail ?? "")))
    }
}
