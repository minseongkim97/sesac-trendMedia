//
//  CreditHeaderView.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/09.
//

import UIKit

import Kingfisher

class CreditHeaderView: UIView {
    //MARK: - Properties
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    //MARK: - Helpers
    func configureHeaderView(tv: TV) {
        nameLabel.text = tv.title
        if let posterPath = tv.thumbnail {
            posterImageView.kf.setImage(with: URL(string: EndPoint.imagePath + posterPath))
        }
        if let backdropPath = tv.backdropPath {
            print(EndPoint.imagePath + backdropPath)
            backdropImageView.kf.setImage(with: URL(string: EndPoint.imagePath + backdropPath))
        }
    }
}
