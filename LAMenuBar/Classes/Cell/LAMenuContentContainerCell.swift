//
//  LAMenuContentContainerCell.swift
//  LAMenuBar
//
//  Created by Luis Arias on 8/10/17.
//
//

import Foundation

public final class LAMenuContentContainerCell: UICollectionViewCell {
  
  static let identifier = "LAMenuContentContainerCell"
  
  func configuration(with container: UIView) {
    self.addSubview(container)
    
    self.addConstraintsWithFormat(format: "H:|[v0]|", view: container)
    self.addConstraintsWithFormat(format: "V:|[v0]|", view: container)
  }
}
