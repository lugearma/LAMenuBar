//
//  Extensions.swift
//  LAMenuBar
//
//  Created by Luis Arias on 6/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
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
