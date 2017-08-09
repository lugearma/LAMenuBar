//
//  LAMenuContentContainer.swift
//  LAMenuBar
//
//  Created by Luis Arias on 8/2/17.
//

import Foundation

protocol LAMenuContentContainerDelegate: class {
  
  func didScroll(scrollView: UIScrollView)
}

public final class LAMenuContentContainer: UICollectionView {
  
  weak var menuDelegate: LAMenuContentContainerDelegate?
  
  override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    self.delegate = self
    self.dataSource = self
    self.isPagingEnabled = true
  }
  
  required public convenience init?(coder aDecoder: NSCoder) {
    self.init(coder: aDecoder)
  }
  
  func configuration(delegate: LAMenuContentContainerDelegate) {
    self.menuDelegate = delegate
  }
}

// MARK: UICollectionViewDataSource

extension LAMenuContentContainer: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    let colors = [UIColor.red, UIColor.blue, UIColor.black, UIColor.blue, UIColor.red, ]
    cell.backgroundColor = colors[indexPath.item]
    return cell
  }
}

// MARK: UICollectionViewDelegate

extension LAMenuContentContainer: UICollectionViewDelegate {
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    // Call delegate
    menuDelegate?.didScroll(scrollView: scrollView)
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension LAMenuContentContainer: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.frame.width, height: self.frame.height)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
