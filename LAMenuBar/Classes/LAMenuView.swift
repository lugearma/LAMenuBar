//
//  LAMenuView.swift
//  LAMenuBar
//
//  Created by Luis Arias on 8/8/17.
//

import UIKit

@available(iOS 9.0, *)
public class LAMenuView: UIView {
  
  lazy var menuBar: LAMenuBar = {
    let mb = LAMenuBar()
    mb.imagesNames = ["home", "trending", "subscriptions", "account"]
    return mb
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupMenuBar()
    setupContainer()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupContainer() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = LAMenuContentContainer(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), collectionViewLayout: layout)
    collectionView.backgroundColor = .red
    self.addSubview(collectionView)
    
    self.addConstraintsWithFormat(format: "H:|[v0]|", view: collectionView)
    self.addConstraintsWithFormat(format: "V:|-\(50)-[v0]|", view: collectionView)
  }
  
  private func setupMenuBar() {
    self.addSubview(menuBar)
    
    self.addConstraintsWithFormat(format: "H:|[v0]|", view: menuBar)
    self.addConstraintsWithFormat(format: "V:|[v0(50)]", view: menuBar)
  }
}
