//
//  LAMenuModel.swift
//  Pods
//
//  Created by Luis Arias on 8/17/17.
//
//

import Foundation

public struct LAMenuModel {
  
  public let images: [UIImage?]
  public let backgroundColor: UIColor
  public let sectionIndicatorBarColor: UIColor
  public let colorWhenSelected: UIColor
  public let colorWhenDiselected: UIColor
  public let sections: Int
  public let views: [UIView]
  public let isCurrentSectionBarHidden: Bool
  public let menuBarPosition: MenuBarPosition
  
  public init(images: [UIImage?], backgroundColor: UIColor, barColor: UIColor, tintColorWhenSelected: UIColor, tintColorWhenDiselected: UIColor, views: [UIView], isCurrentSectionBarHidden: Bool, menuBarPosition: MenuBarPosition) {
    self.images = images
    self.backgroundColor = backgroundColor
    self.sectionIndicatorBarColor = barColor
    self.colorWhenSelected = tintColorWhenSelected
    self.colorWhenDiselected = tintColorWhenDiselected
    self.sections = views.count
    self.views = views
    self.isCurrentSectionBarHidden = isCurrentSectionBarHidden
    self.menuBarPosition = menuBarPosition
  }
}
