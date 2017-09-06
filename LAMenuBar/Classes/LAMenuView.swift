//
//  LAMenuView.swift
//  LAMenuBar
//
//  Created by Luis Arias on 8/8/17.
//

import UIKit

@available(iOS 9.0, *)
public protocol LAMenuViewDelegate: class {
  
  func menuView(_ view: LAMenuView, didScrollWithIndex index: IndexPath)
  func menuView(_ view: LAMenuView, didSelectMenuItemAtIndex index: IndexPath)
}

@available(iOS 9.0, *)
public class LAMenuView: UIView {

  public var model: LAMenuModel? {
    didSet {
      guard let menuContentContainer = menuContentContainer, let model = model else { fatalError("Can not load model") }
      
      menuContentContainer.views = model.views
      menuBar.images = model.images
    }
  }
  
  lazy var menuBar: LAMenuBar = {
    let mb = LAMenuBar()
    
    return mb
  }()
  
  fileprivate var menuContentContainer: LAMenuContentContainer?
  private var numberOfSections: Int?
  
  public weak var delegate: LAMenuViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupContainer()
  }
  
  public override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    setupMenuBar()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configuration(delegate: LAMenuViewDelegate) {
    self.delegate = delegate
  }
  
  private func setupContainer() {
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    menuContentContainer = LAMenuContentContainer(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), collectionViewLayout: layout)
    
    if let menuContentContainer = menuContentContainer {
      menuContentContainer.configuration(delegate: self)
      menuBar.configuration(delegate: self)
      
      self.addSubview(menuContentContainer)
      
      self.addConstraintsWithFormat(format: "H:|[v0]|", view: menuContentContainer)
      self.addConstraintsWithFormat(format: "V:|-\(50)-[v0]|", view: menuContentContainer)
    }
  }
  
  private func setupMenuBar() {
    menuBar.model = model
    self.addSubview(menuBar)
    
    self.addConstraintsWithFormat(format: "H:|[v0]|", view: menuBar)
    self.addConstraintsWithFormat(format: "V:|[v0(50)]", view: menuBar)
  }
}

@available(iOS 9.0, *)
extension LAMenuView: LAMenuContentContainerDelegate {
  
  func didScroll(scrollView: UIScrollView) {
    menuBar.updateWhenScrollView(scrollView)
  }
  
  func didEndScrollWithIndex(index: IndexPath) {
    menuBar.updateWhenFinishScrollAtIndex(index)
    delegate?.menuView(self, didScrollWithIndex: index)
  }
}

@available(iOS 9.0, *)
extension LAMenuView: LAMenuBarDelegate {
  
  func didSelectItemAt(indexPath: IndexPath) {
    menuContentContainer?.updateWhenSelectItemAtIndex(indexPath)
    delegate?.menuView(self, didSelectMenuItemAtIndex: indexPath)
  }
}
