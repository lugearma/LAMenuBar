//
//  UICollectionView.swift
//  LAMenuBar
//
//  Created by Luis Arias on 3/18/18.
//

import Foundation

extension UICollectionView {
  
  func dequeCell<T>(identifier: String, indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
      preconditionFailure("Can not dequeue cell whit identifier \(identifier)")
    }
    return cell
  }
}
