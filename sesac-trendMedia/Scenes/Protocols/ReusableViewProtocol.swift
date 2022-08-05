//
//  ReusableViewProtocol.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/05.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol { // extension 저장 프로퍼티 불가능
    
    static var identifier: String { // 연산 프로퍼티 get만 사용한다면 get 생략 가능
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

