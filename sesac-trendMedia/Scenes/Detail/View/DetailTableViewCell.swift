//
//  DetailTableViewCell.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/05.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    //MARK: - Properties
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var castingLabel: UILabel!
    
    //MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        personImageView.image = UIImage(systemName: "person.fill")
    }
    
    //MARK: - Helpers
    func configureCell(credit: Cast) {
        if let profilePath = credit.profilePath {
            personImageView.kf.setImage(with: URL(string: EndPoint.imagePath + profilePath))
        }
        nameLabel.text = credit.name
        castingLabel.text = credit.character
    }
    
    func configureCell(credit: Crew) {
        if let profilePath = credit.profilePath {
            personImageView.kf.setImage(with: URL(string: EndPoint.imagePath + profilePath))
        }
        nameLabel.text = credit.name
        castingLabel.text = credit.job
    }
}
