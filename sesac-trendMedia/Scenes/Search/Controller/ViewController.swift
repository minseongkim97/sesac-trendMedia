//
//  ViewController.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/04.
//

import UIKit

import Alamofire
import JGProgressHUD
import Kingfisher
import SwiftyJSON

class ViewController: UIViewController {
    //MARK: - Properties
    let hud = JGProgressHUD()
    
    var startPage = 1
    var totalPage = 0
    var list: [TV] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tmdbCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tmdbCollectionView: UICollectionView! {
        didSet {
            tmdbCollectionView.delegate = self
            tmdbCollectionView.dataSource = self
            tmdbCollectionView.register(UINib(nibName: SearchCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
            tmdbCollectionView.collectionViewLayout = collectionViewLayout()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTMDB(pagination: false, startPage: 1)
    }

    //MARK: - Helpers
    func requestTMDB(pagination: Bool, startPage: Int) {
        hud.show(in: self.view)
        APIManager.shared.requestTMDB(pagination: pagination, page: startPage) { [weak self] totalPage, tvs in
            self?.totalPage = totalPage
            self?.list.append(contentsOf: tvs)
            self?.hud.dismiss()
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: width * 1.23)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
        return layout
    }

//    private func createSpinnerFooter() -> UIView {
//        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
//
//        let spinner = UIActivityIndicatorView()
//        spinner.center = footerView.center
//        footerView.addSubview(spinner)
//        spinner.startAnimating()
//
//        return footerView
//    }
}

//MARK: - Extension: UICollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(tv: list[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailVC = UIStoryboard(name: StoryboardName.detail, bundle: nil).instantiateViewController(identifier: DetailViewController.identifier)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        guard !APIManager.shared.isPaginating else { return }
        if (position > (tmdbCollectionView.contentSize.height - 100 - scrollView.frame.size.height)) && startPage < totalPage {
            startPage += 1
            requestTMDB(pagination: true, startPage: startPage)
        }
    }
}

