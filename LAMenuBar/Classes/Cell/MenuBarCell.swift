//
//  MenuBarCell.swift
//  Pods
//
//  Created by Luis Arias on 6/11/17.
//
//

import UIKit

// MARK: - MenuBarCellModel

struct MenuBarCellModel {
  let colorWhenSelected: UIColor
  let colorWhenDiselected: UIColor
  let image: UIImage
  let cellIndex: Int
}

// MARK: - MenuBarCell

final class MenuBarCell: UICollectionViewCell {
  
  static let identifier = "MenuCellIdentifier"
  
  var model: MenuBarCellModel?
  let sectionIconImageView = UIImageView()
  
  override var isHighlighted: Bool {
    didSet {
      sectionIconImageView.tintColor = isHighlighted ? model?.colorWhenSelected ?? .black : model?.colorWhenDiselected ?? .lightGray
    }
  }
  
  override var isSelected: Bool {
    didSet {
      sectionIconImageView.tintColor = isSelected ? model?.colorWhenSelected ?? .black : model?.colorWhenDiselected ?? .lightGray
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setupViews() {
    addSubview(sectionIconImageView)
    addConstraintsWithFormat(format: "H:[v0(28)]", view: sectionIconImageView)
    addConstraintsWithFormat(format: "V:[v0(28)]", view: sectionIconImageView)
    addConstraint(NSLayoutConstraint(item: sectionIconImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: sectionIconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
  
  func configure() {
    tintColor = model?.colorWhenDiselected
    sectionIconImageView.image = model?.image.withRenderingMode(.alwaysTemplate)
    if model?.cellIndex == 0 {
      sectionIconImageView.tintColor = model?.colorWhenSelected
    }
  }
}
