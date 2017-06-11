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

public final class LAMenuBar: UIView {
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
    
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    
    backgroundColor = .red
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    addSubview(collectionView)
    
    addConstraintsWithFormat(format: "H:|[v0]|", view: collectionView)
    addConstraintsWithFormat(format: "V:|[v0]|", view: collectionView)
  }
}

// MARK: - UICollectionViewDataSource

extension LAMenuBar: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else { fatalError() }
    
    
    cell.backgroundColor = indexPath.row % 2 == 0 ? .blue : .red
    
    return cell
  }
}

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

extension LAMenuBar: UICollectionViewDelegate {
}
