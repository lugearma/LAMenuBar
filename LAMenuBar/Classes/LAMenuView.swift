//
//  LAMenuView.swift
//  LAMenuBar
//
//  Created by Luis Arias on 8/8/17.
//

import UIKit

// MARK: - MenuBarPosition

public enum MenuBarPosition {
  case top
  case bottom
}

// MARK: - LAMenuViewDelegate

@available(iOS 9.0, *)
public protocol LAMenuViewDelegate: class {
  func menuView(_ view: LAMenuView, didScrollWithIndex index: IndexPath)
  func menuView(_ view: LAMenuView, didSelectMenuItemAtIndex index: IndexPath)
}

// MARK: - LAMenuView

@available(iOS 9.0, *)
public class LAMenuView: UIView {

  public weak var delegate: LAMenuViewDelegate?
  private var model: LAMenuModel
  
  var stackSubviews: (UIView, UIView) {
    switch model.menuBarPosition {
    case .top:
      return (menuBar, menuContentContainer)
    case .bottom:
      return (menuContentContainer, menuBar)
    }
  }
  
  fileprivate lazy var containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubviews(self.stackSubviews.0, self.stackSubviews.1)
    return stackView
  }()
  
  fileprivate lazy var menuBar: LAMenuBar = {
    let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 50)
    let menuBar = LAMenuBar(frame: frame, model: self.model)
    menuBar.translatesAutoresizingMaskIntoConstraints = false
    menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    menuBar.delegate = self
    return menuBar
  }()
  
  fileprivate lazy var menuContentContainer: LAMenuContentContainer = {
    let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    let menuContentContainer = LAMenuContentContainer(frame: frame, model: self.model)
    menuContentContainer.contentContainerDelegate = self
    return menuContentContainer
  }()
  
  public init(frame: CGRect, model: LAMenuModel) {
    self.model = model
    super.init(frame: frame)
    setupViews()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    addSubview(containerStackView)
    containerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    containerStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    containerStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
  }
}

// MARK: - LAMenuContentContainerDelegate

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

// MARK: - LAMenuBarDelegate

@available(iOS 9.0, *)
extension LAMenuView: LAMenuBarDelegate {
  
  func didSelectItemAt(indexPath: IndexPath) {
    menuContentContainer.updateWhenSelectItemAtIndex(indexPath)
    delegate?.menuView(self, didSelectMenuItemAtIndex: indexPath)
  }
}
