//
//  UIImageView.swift
//  client-ipad
//
//  Created by Alexandre Page on 15/06/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func asCircle(borderWidth: CGFloat = 1) {
    self.layer.cornerRadius = self.bounds.size.height / 2
    self.clipsToBounds = true
    self.layer.borderWidth = borderWidth
    self.layer.borderColor = UIColor.white.cgColor
  }
  
  func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() {
        self.image = image
      }
      }.resume()
  }
  
  func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
    guard let url = URL(string: link) else { return }
    downloadedFrom(url: url, contentMode: mode)
  }
  
}
