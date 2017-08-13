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
    
    let menuView = LAMenuView()
    
    let fV = UIView()
    fV.backgroundColor = .blue
    
    let sV = UIView()
    sV.backgroundColor = .black
    
    let tV = UIView()
    tV.backgroundColor = .red
    
    let foV = UIView()
    foV.backgroundColor = .yellow
    
    let views = [fV, sV, tV, foV]
    menuView.model = LAMenuModel(images: [UIImage(named: "")], backgroundColor: .red, sections: 4, views: views)
  
    view.addSubview(menuView)
    
    view.addConstraintsWithFormat(format: "H:|[v0]|", view: menuView)
    view.addConstraintsWithFormat(format: "V:|[v0]|", view: menuView)
  }
  
  func configurateNavigationBar() {
    navigationController?.navigationBar.isTranslucent = false
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
  }
}
