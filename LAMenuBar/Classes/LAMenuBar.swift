//
//  LAMenuBar.swift
//  Pods
//
//  Created by Luis Arias on 6/11/17.
//
//

import UIKit

protocol LAMenuBarDelegate: class {
  
  func didSelectItemAt(indexPath: Int)
}

public struct LAMenuModel {
  
  public let images: [UIImage?]
  public let backgroundColor: UIColor
  public let sections: Int
  public let views: [UIView]
  
  public init(images: [UIImage?], backgroundColor: UIColor, views: [UIView]) {
    self.images = images
    self.backgroundColor = backgroundColor
    self.sections = views.count
    self.views = views
  }
}

@available(iOS 9.0, *)
public final class LAMenuBar: UIView {
  
  public var images: [UIImage?]?
  public var numberOfSections: Int?
  
  fileprivate weak var delegate: LAMenuBarDelegate?
  fileprivate var leftAnchorContraint: NSLayoutConstraint?
  
  fileprivate lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    let selectedIndexPath = IndexPath(row: 0, section: 0)
    
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: MenuBarCell.identifier)
    collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    return collectionView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setHorizontalBar()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configuration(delegate: LAMenuBarDelegate) {
    self.delegate = delegate
  }
  
  fileprivate func setHorizontalBar() {
    
    let horizontalBarView = UIView()
    
    //TODO: Set custom color
    horizontalBarView.backgroundColor = .blue
    horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(horizontalBarView)
    
    leftAnchorContraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
    let bottomAnchorContraint = horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    let anchorConstraintForBotton = horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4)
    let anchorConstraintForHeight = horizontalBarView.heightAnchor.constraint(equalToConstant: 4)
    
    guard let leftAnchorContraint = leftAnchorContraint else { fatalError() }
    
    NSLayoutConstraint.activate([leftAnchorContraint, bottomAnchorContraint, anchorConstraintForBotton, anchorConstraintForHeight])
  }
  
  fileprivate func setupView() {
    addSubview(collectionView)
    
    addConstraintsWithFormat(format: "H:|[v0]|", view: collectionView)
    addConstraintsWithFormat(format: "V:|[v0(50)]", view: collectionView)
  }
}

// MARK: - UICollectionViewDataSource

@available(iOS 9.0, *)
extension LAMenuBar: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarCell.identifier, for: indexPath) as? MenuBarCell else { fatalError() }
    
    guard let image = images?[indexPath.row] else { fatalError() }
    cell.configurate(for: image)
    
    cell.tintColor = .lightGray
    
    return cell
  }
}

// MARK: UICollectionViewDelegateFlowLayout

@available(iOS 9.0, *)
extension LAMenuBar: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = frame.width / 4
    
    return CGSize(width: width, height: frame.height)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

// MARK: - UICollectionViewDelegate

@available(iOS 9.0, *)
extension LAMenuBar: UICollectionViewDelegate {
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    delegate?.didSelectItemAt(indexPath: indexPath.item)
  }
}

@available(iOS 9.0, *)
extension LAMenuBar: LAMenuContentContainerDelegate {
  
  func didScroll(scrollView: UIScrollView) {
    self.leftAnchorContraint?.constant = scrollView.contentOffset.x / 4
  }
  
  func didEndScrollWithIndex(index: IndexPath) {
    self.collectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
  }
}
