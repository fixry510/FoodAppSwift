//
//  Extension+Font.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import UIKit


extension UIFont {
    public static func quickSand(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        var font = "Quicksand-Regular"
        switch weight {
        case .bold:
            font = "Quicksand-Bold"
        case .light:
            font = "Quicksand-Light"
        case .medium:
            font = "Quicksand-Regular"
        case .semibold:
            font = "Quicksand-SemiBold"
        case .thin:
            font = "Quicksand-Light"
        case .ultraLight:
            font = "Quicksand-Light"
        default: break
        }
        return UIFont(name: font, size: size)!
    }
}

