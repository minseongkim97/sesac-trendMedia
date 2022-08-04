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
    var list: [Movie] = [] {
        didSet {
            tmdbCollectionView.reloadData()
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
        requestTMDB()
    }

    //MARK: - Helpers
    func requestTMDB() {
        hud.show(in: self.view)
        let url = EndPoint.trendingURL + "api_key=\(APIKey.tmdbKey)"
        
        AF.request(url, method: .get).validate().responseData { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                self?.hud.dismiss()
                
            case .failure(let error):
                self?.hud.dismiss()
                print(error)
            }
        }
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: width * 1.25)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
        return layout
    }

}

//MARK: - Extension: UICollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

