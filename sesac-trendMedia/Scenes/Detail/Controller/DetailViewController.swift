//
//  DetailViewController.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/05.
//

import UIKit

import JGProgressHUD

class DetailViewController: UIViewController {
    //MARK: - Properties
    let hud = JGProgressHUD()
    
    var tv = TV.defaultTV()
    var isExpanded: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.creditTableView.reloadData()
            }
        }
    }
    
    var castList: [Cast] = [] {
        didSet {
            DispatchQueue.main.async {
                self.creditTableView.reloadData()
            }
        }
    }
    
    var crewList: [Crew] = [] {
        didSet {
            DispatchQueue.main.async {
                self.creditTableView.reloadData()
            }
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var creditTableView: UITableView! {
        didSet {
            creditTableView.delegate = self
            creditTableView.dataSource = self
            creditTableView.register(UINib(nibName: OverViewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OverViewTableViewCell.identifier)
            creditTableView.register(UINib(nibName: DetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.identifier)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCredits()
        configureHeaderView(tv: tv)
    }
    
    //MARK: - Helpers
    func requestCredits() {
        hud.show(in: self.view)
        APIManager.shared.requestTVCredits(id: tv.id) { [weak self] casts, crews in
            self?.castList = casts
            self?.crewList = crews
            DispatchQueue.main.async {
                self?.hud.dismiss(animated: true)
            }
        }
    }
    
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

//MARK: - Extension: UITableView
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return castList.count
        case 2:
            return crewList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "OverView"
        case 1:
            return "Cast"
        case 2:
            return "Crew"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let overviewCell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier, for: indexPath) as? OverViewTableViewCell else { return UITableViewCell() }
            overviewCell.configureCell(overview: tv.overview)
            return overviewCell
        case 1:
            guard let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
            detailCell.configureCell(credit: castList[indexPath.row])
            return detailCell
        case 2:
            guard let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
            detailCell.configureCell(credit: crewList[indexPath.row])
            return detailCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            guard let cell = tableView.cellForRow(at: indexPath) as? OverViewTableViewCell else { return }
            cell.moreButton.isHidden = !cell.moreButton.isHidden
            isExpanded = !isExpanded
            cell.overviewLabel.numberOfLines = isExpanded ? 0 : 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 140
        case 2:
            return 140
        default:
            return 0
        }
    }
}
