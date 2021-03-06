//
//  UIView.swift
//  client-ipad
//
//  Created by Alexandre Page on 30/09/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

enum ViewBorder: String {
  case left, right, top, bottom
}

extension UIView {
  
  func add(border: ViewBorder, color: UIColor, width: CGFloat) {
    let borderLayer = CALayer()
    borderLayer.backgroundColor = color.cgColor
    borderLayer.name = border.rawValue
    switch border {
    case .left:
      borderLayer.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
    case .right:
      borderLayer.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
    case .top:
      borderLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
    case .bottom:
      borderLayer.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
    }
    self.layer.addSublayer(borderLayer)
  }
  
  func remove(border: ViewBorder) {
    guard let sublayers = self.layer.sublayers else { return }
    var layerForRemove: CALayer?
    for layer in sublayers {
      if layer.name == border.rawValue {
        layerForRemove = layer
      }
    }
    if let layer = layerForRemove {
      layer.removeFromSuperlayer()
    }
  }

  func addConstraintsWithFormat(format: String, views: UIView...) {
    
    var viewDictionary = [String: UIView]()
    
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      viewDictionary[key] = view
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                       options: NSLayoutFormatOptions(),
                                                       metrics: nil,
                                                       views: viewDictionary))
    
  }
  
  func viewWithRestorationTag(str: String) -> UIView? {
    for view in self.subviews {
      if view.restorationIdentifier == str {
        return view
      }
    }
    return nil
  }
}
