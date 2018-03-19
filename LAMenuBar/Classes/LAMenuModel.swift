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
  public let viewControllers: [UIViewController]
  public let isCurrentSectionBarHidden: Bool
  public let menuBarPosition: MenuBarPosition
  
  public init(images: [UIImage?], backgroundColor: UIColor, barColor: UIColor, tintColorWhenSelected: UIColor, tintColorWhenDiselected: UIColor, viewControllers: [UIViewController], isCurrentSectionBarHidden: Bool, menuBarPosition: MenuBarPosition) {
    self.images = images
    self.backgroundColor = backgroundColor
    self.sectionIndicatorBarColor = barColor
    self.colorWhenSelected = tintColorWhenSelected
    self.colorWhenDiselected = tintColorWhenDiselected
    self.sections = viewControllers.count
    self.viewControllers = viewControllers
    self.isCurrentSectionBarHidden = isCurrentSectionBarHidden
    self.menuBarPosition = menuBarPosition
  }
}
