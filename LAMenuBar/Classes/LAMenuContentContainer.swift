//
//  LAMenuContentContainer.swift
//  LAMenuBar
//
//  Created by Luis Arias on 8/2/17.
//

import Foundation

//MARK: - LAMenuContentContainerDelegate

protocol LAMenuContentContainerDelegate: class {
  func didScroll(scrollView: UIScrollView)
  func didEndScrollWithIndex(index: IndexPath)
}

// MARK: - LAMenuContentContainer

final class LAMenuContentContainer: UICollectionView {
  
  weak var contentContainerDelegate: LAMenuContentContainerDelegate?
  var views: [UIView]
  
  init(frame: CGRect, model: LAMenuModel) {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    self.views = model.views
    super.init(frame: frame, collectionViewLayout: layout)
    setupCollectionView()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(coder: aDecoder)
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

// MARK: - UICollectionViewDataSource

extension LAMenuContentContainer: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return views.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: LAMenuContentContainerCell = collectionView.dequeCell(identifier: LAMenuContentContainerCell.identifier, indexPath: indexPath)
    let view = views[indexPath.row]
    cell.configuration(with: view)
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension LAMenuContentContainer: UICollectionViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    contentContainerDelegate?.didScroll(scrollView: scrollView)
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let row = Int(targetContentOffset.pointee.x / self.frame.width)
    let index = IndexPath(row: row, section: 0)
    contentContainerDelegate?.didEndScrollWithIndex(index: index)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LAMenuContentContainer: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.frame.width, height: self.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
