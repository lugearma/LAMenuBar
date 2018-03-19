//
//  UIStackView.swift
//  LAMenuBar
//
//  Created by Luis Arias on 3/18/18.
//

import Foundation

@available(iOS 9.0, *)
extension UIStackView {
  
  func addArrangedSubviews(_ views: UIView...) {
    views.forEach {
      addArrangedSubview($0)
    }
  }
}
