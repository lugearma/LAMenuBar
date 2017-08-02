//
//  LAMenuBar.swift
//  Pods
//
//  Created by Luis Arias on 6/11/17.
//
//

import UIKit

extension UIView {
  
  func addConstraintsWithFormat(format: String, view: UIView...) {
    
    var viewDictionary = [String: UIView]()
    
    for (index, view) in view.enumerated() {
      let key = "v\(index)"
      viewDictionary[key] = view
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
  }
}

public struct LAMenuModel {
  
  public let imagesNames: [String]
  public let backgroundColor: UIColor
}

@available(iOS 9.0, *)
public final class LAMenuBar: UIView {
  
  fileprivate var leftAnchorContraint: NSLayoutConstraint?
  public var imagesNames: [String]?
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    let selectedIndexPath = IndexPath(row: 0, section: 0)
    
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
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
  
  fileprivate func setHorizontalBar() {
    
    let horizontalBarView = UIView()
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
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else { fatalError() }
    
    guard let imageName = imagesNames?[indexPath.row] else { fatalError() }
    cell.configurate(for: imageName)
    
    cell.tintColor = .lightGray
    
    return cell
  }
}

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
    // TODO: Change number of items
    let x = CGFloat(indexPath.item) * frame.width / 4
    leftAnchorContraint?.constant = x
    
  }
}
