//
//  UIImageView-Extension.swift
//  Marvel
//
//  Created by Alberto on 26/6/21.
//

import Foundation
import UIKit

extension UIImageView {
    func cornerRadius(radius: Int){
        self.layer.cornerRadius = CGFloat(radius)
    }
}
