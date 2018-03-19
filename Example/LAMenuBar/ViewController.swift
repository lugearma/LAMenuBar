//
//  ViewController.swift
//  LAMenuBar
//
//  Created by Luis Arias on 06/11/2017.
//  Copyright (c) 2017 Luis Arias. All rights reserved.
//

import UIKit
import LAMenuBar

@available(iOS 9.0, *)
class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .gray
    configurateNavigationBar()
    setupMenuView()
  }
  
  private func setupMenuView() {
    
    // Create array of view controller that are going to be presented in each section
    let viewControllers = [
      FirstViewController(),
      SecondViewController(),
      ThirdViewController(),
      FourthViewController()
    ]
    
    // Create a model which has the information to present
    let images = [
      UIImage(named: "home"),
      UIImage(named: "trending"),
      UIImage(named: "subscriptions"),
      UIImage(named: "account")
    ]
    let model = LAMenuModel(images: images, backgroundColor: .white, barColor: .black, tintColorWhenSelected: .black, tintColorWhenDiselected: .lightGray, viewControllers: viewControllers, isCurrentSectionBarHidden: false, menuBarPosition: .top)
    
    // Create LAMenuView and add to your view
    let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    let menuView = LAMenuView(frame: frame, model: model)
    menuView.translatesAutoresizingMaskIntoConstraints = false
    
    // Set the model
    menuView.delegate = self
  
    view.addSubview(menuView)
    
    menuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    menuView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    menuView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
  }
  
  func configurateNavigationBar() {
    navigationController?.navigationBar.isTranslucent = false
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
  }
}

// MARK: - LAMenuViewDelegate

@available(iOS 9.0, *)
extension ViewController: LAMenuViewDelegate {
  
  func menuView(_ view: LAMenuView, didScrollWithIndex index: IndexPath) {
    print(#function)
  }
  
  func menuView(_ view: LAMenuView, didSelectMenuItemAtIndex index: IndexPath) {
    print("Index:", index.item)
  }
}
