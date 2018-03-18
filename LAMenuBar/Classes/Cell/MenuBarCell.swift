//
//  MenuBarCell.swift
//  Pods
//
//  Created by Luis Arias on 6/11/17.
//
//

import UIKit

public final class MenuBarCell: UICollectionViewCell {
  
  static let identifier = "MenuCellIdentifier"
  
  public var tintColorWhenSelected: UIColor?
  public var tintColorWhenDiselected: UIColor?
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  public override var isHighlighted: Bool {
    didSet {
      imageView.tintColor = isHighlighted ? tintColorWhenSelected ?? .black : tintColorWhenDiselected ?? .lightGray
    }
  }
  
  public override var isSelected: Bool {
    didSet {
      imageView.tintColor = isSelected ? tintColorWhenSelected ?? .black : tintColorWhenDiselected ?? .lightGray
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setupViews() {
    addSubview(imageView)
    addConstraintsWithFormat(format: "H:[v0(28)]", view: imageView)
    addConstraintsWithFormat(format: "V:[v0(28)]", view: imageView)
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
  
  func configurate(for image: UIImage, tintColorWhenSelected: UIColor?, tintColorWhenDiselected: UIColor?, index: Int) {
    
    imageView.image = image.withRenderingMode(.alwaysTemplate)
    self.tintColorWhenSelected = tintColorWhenSelected
    self.tintColorWhenDiselected = tintColorWhenDiselected
    
    // Paint the first cell
    if index == 0 {
      imageView.tintColor = tintColorWhenSelected
    }
  }
}
