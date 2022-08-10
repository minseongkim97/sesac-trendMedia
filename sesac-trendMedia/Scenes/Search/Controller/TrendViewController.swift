//
//  TrendViewController.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/10.
//

import UIKit

class TrendViewController: UIViewController {
    //MARK: - Properties
    let color: [UIColor] = [.red, .magenta, .brown, .cyan, .green]
    let numberList: [[Int]] = [
        [Int](100...110),
        [Int](55...75),
        [Int](5000...5006),
        [Int](51...60),
        [Int](61...70),
        [Int](71...80),
        [Int](81...90)
    ]
    
    @IBOutlet weak var bannerCollectionView: UICollectionView! {
        didSet {
            bannerCollectionView.delegate = self
            bannerCollectionView.dataSource = self
            bannerCollectionView.register(UINib(nibName: TrendCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
            bannerCollectionView.isPagingEnabled = true
        }
    }
    
    @IBOutlet weak var mainTableView: UITableView! {
        didSet {
            mainTableView.delegate = self
            mainTableView.dataSource = self
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
    }
}

//MARK: - Extension: UITableView
extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .yellow
        cell.contentCollectionView.backgroundColor = .lightGray
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.tag = indexPath.section
        cell.contentCollectionView.register(UINib(nibName: TrendCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}

//MARK: - Extension: UICollectionView
extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? color.count : numberList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else { return UICollectionViewCell() }
        
        if collectionView == bannerCollectionView {
            cell.mediaImageView.backgroundColor = color[indexPath.item]
        } else {
            cell.mediaImageView.backgroundColor = .black
            cell.contentLabel.textColor = .white
            cell.contentLabel.text = "\(numberList[collectionView.tag][indexPath.item])"
        }
        
        cell.mediaImageView.image = UIImage(systemName: "person.fill")
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: bannerCollectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
