//
//  LAMenuContentContainer.swift
//  LAMenuBar
//
//  Created by Luis Arias on 8/2/17.
//

import Foundation

protocol LAMenuContentContainerDelegate: class {
  
  func didScroll(scrollView: UIScrollView)
  func didEndScrollWithIndex(index: IndexPath)
}

public final class LAMenuContentContainer: UICollectionView {
  
  weak var contentContainerDelegate: LAMenuContentContainerDelegate?
  var views: [UIView]?
  
  override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    setupCollectionView()
  }
  
  required public convenience init?(coder aDecoder: NSCoder) {
    self.init(coder: aDecoder)
  }
  
  func configuration(delegate: LAMenuContentContainerDelegate) {
    self.contentContainerDelegate = delegate
  }
  
  private func setupCollectionView() {
    self.register(LAMenuContentContainerCell.self, forCellWithReuseIdentifier: LAMenuContentContainerCell.identifier)
    self.delegate = self
    self.dataSource = self
    self.isPagingEnabled = true
    self.showsHorizontalScrollIndicator = false
    self.bounces = false
  }
  
  func updateWhenSelectItemAtIndex(_ index: IndexPath) {
    self.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
  }
}

// MARK: UICollectionViewDataSource

extension LAMenuContentContainer: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return views?.count ?? 0
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LAMenuContentContainerCell.identifier, for: indexPath) as? LAMenuContentContainerCell else { fatalError() }
    
    guard let view = views?[indexPath.row] else { fatalError() }
    
    cell.configuration(with: view)
    
    return cell
  }
}

// MARK: UICollectionViewDelegate

extension LAMenuContentContainer: UICollectionViewDelegate {
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    // Call delegate
    contentContainerDelegate?.didScroll(scrollView: scrollView)
  }
  
  public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
  
    let row = Int(targetContentOffset.pointee.x / self.frame.width)
    let index = IndexPath(row: row, section: 0)

    contentContainerDelegate?.didEndScrollWithIndex(index: index)
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
