//
//  LAMenuBar.swift
//  Pods
//
//  Created by Luis Arias on 6/11/17.
//
//

import UIKit

protocol LAMenuBarDelegate: class {
  func didSelectItemAt(indexPath: IndexPath)
}

@available(iOS 9.0, *)
final class LAMenuBar: UIView {
  
  fileprivate var model: LAMenuModel
  weak var delegate: LAMenuBarDelegate?
  fileprivate var leftAnchorContraint: NSLayoutConstraint?
  
  fileprivate lazy var sectionsBarView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    let selectedIndexPath = IndexPath(row: 0, section: 0)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: MenuBarCell.identifier)
    collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    return collectionView
  }()
  
  private lazy var sectionIndicatorBar: UIView = {
    let view = UIView()
    view.backgroundColor = self.model.sectionIndicatorBarColor
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  init(frame: CGRect, model: LAMenuModel) {
    self.model = model
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    setupView()
    setupSectionIndicatorBar()
  }
  
  private func setupSectionIndicatorBar() {
    addSubview(sectionIndicatorBar)
    leftAnchorContraint = sectionIndicatorBar.leftAnchor.constraint(equalTo: leftAnchor)
    let bottomAnchorContraint = sectionIndicatorBar.bottomAnchor.constraint(equalTo: bottomAnchor)
    let anchorConstraintForBotton = sectionIndicatorBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/CGFloat(model.sections))
    let anchorConstraintForHeight = sectionIndicatorBar.heightAnchor.constraint(equalToConstant: CGFloat(model.sections))
    
    guard let leftAnchorContraint = leftAnchorContraint else {
      preconditionFailure()
    }
    
    NSLayoutConstraint.activate([leftAnchorContraint, bottomAnchorContraint, anchorConstraintForBotton, anchorConstraintForHeight])
  }
  
  private func setupView() {
    addSubview(sectionsBarView)
    sectionsBarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    sectionsBarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    sectionsBarView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    sectionsBarView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
  }
  
  func updateWhenScrollView(_ scrollView: UIScrollView) {
    let sections = model.sections
    leftAnchorContraint?.constant = scrollView.contentOffset.x / CGFloat(sections)
  }
  
  func updateWhenFinishScrollAtIndex(_ index: IndexPath) {
    self.sectionsBarView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
  }
}

// MARK: - UICollectionViewDataSource

@available(iOS 9.0, *)
extension LAMenuBar: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model.sections
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MenuBarCell = collectionView.dequeCell(identifier: MenuBarCell.identifier, indexPath: indexPath)
    let imageForCell = iconImageForCellAt(indexPath)
    let cellModel = MenuBarCellModel(colorWhenSelected: model.colorWhenSelected, colorWhenDiselected: model.colorWhenDiselected, image: imageForCell, cellIndex: indexPath.item)
    cell.model = cellModel
    cell.configure()
    return cell
  }
  
  private func iconImageForCellAt(_ indexPath: IndexPath) -> UIImage {
    guard let image = model.images[indexPath.item] else {
      preconditionFailure("Can not load image for cell")
    }
    return image
  }
}

// MARK: UICollectionViewDelegateFlowLayout

@available(iOS 9.0, *)
extension LAMenuBar: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let sections = model.sections
    let width = frame.width / CGFloat(sections)
    return CGSize(width: width, height: frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

// MARK: - UICollectionViewDelegate

@available(iOS 9.0, *)
extension LAMenuBar: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let index = IndexPath(item: indexPath.item, section: 0)
    delegate?.didSelectItemAt(indexPath: index)
  }
}
