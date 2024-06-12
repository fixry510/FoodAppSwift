//
//  Extension+UIColor.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import UIKit


struct C {
    static let cOrange = UIColor(rgb: 0xffFD7C50)
    static let cBackGround = UIColor(rgb: 0xffE8EDF2)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
         assert(red >= 0 && red <= 255, "Invalid red component")
         assert(green >= 0 && green <= 255, "Invalid green component")
         assert(blue >= 0 && blue <= 255, "Invalid blue component")

         self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
     }

     convenience init(rgb: Int) {
         self.init(
             red: (rgb >> 16) & 0xFF,
             green: (rgb >> 8) & 0xFF,
             blue: rgb & 0xFF
         )
     }
}

