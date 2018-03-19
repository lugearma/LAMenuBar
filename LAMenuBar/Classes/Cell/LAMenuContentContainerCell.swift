//
//  LAMenuContentContainerCell.swift
//  LAMenuBar
//
//  Created by Luis Arias on 8/10/17.
//
//

import Foundation

protocol LAMenuContentContainerCellDelegate: class {
  func didAddViewController(viewController: UIViewController)
}

final class LAMenuContentContainerCell: UICollectionViewCell {
  
  static let identifier = "LAMenuContentContainerCell"
  weak var delegate: LAMenuContentContainerCellDelegate?
  var viewController: UIViewController?
  
  func configuration(with container: UIViewController, delegate: LAMenuContentContainerCellDelegate? = nil) {
    self.delegate = delegate
    viewController = container
    addSubview(container.view)
    addConstraintsWithFormat(format: "H:|[v0]|", view: container.view)
    addConstraintsWithFormat(format: "V:|[v0]|", view: container.view)
    delegate?.didAddViewController(viewController: container)
  }
}
