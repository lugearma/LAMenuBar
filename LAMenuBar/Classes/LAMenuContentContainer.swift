//
//  LAMenuContentContainer.swift
//  LAMenuBar
//
//  Created by Luis Arias on 8/2/17.
//

import Foundation

public final class LAMenuContentContainer: UICollectionView {
  
  override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    self.delegate = self
    self.dataSource = self
  }
  
  required public convenience init?(coder aDecoder: NSCoder) {
    self.init(coder: aDecoder)
  }
}

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

extension LAMenuContentContainer: UICollectionViewDelegate {
  
}

extension LAMenuContentContainer: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.frame.width, height: self.frame.height)
  }
}
