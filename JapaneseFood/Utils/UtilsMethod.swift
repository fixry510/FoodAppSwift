//
//  UtilsMethod.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation


struct UtilsMethod {
    static func formatPrice(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        if let formattedPrice = formatter.string(from: NSNumber(value: number)) {
            return formattedPrice
        } else {
            return "\(number)"
        }
    }
}
