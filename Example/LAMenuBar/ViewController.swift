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
  
  lazy var menuBar: LAMenuBar = {
    let mb = LAMenuBar()
    mb.imagesNames = ["home", "trending", "subscriptions", "account"]
    return mb
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .gray
    
    configurateNavigationBar()
    setupMenuBar()
  }
  
  func configurateNavigationBar() {
    navigationController?.navigationBar.isTranslucent = false
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
  }
  
  private func setupMenuBar() {
    view.addSubview(menuBar)
    
    view.addConstraintsWithFormat(format: "H:|[v0]|", view: menuBar)
    view.addConstraintsWithFormat(format: "V:|[v0(50)]", view: menuBar)
  }
}

