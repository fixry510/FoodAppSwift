//
//  MenuDetail.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation

struct MenuDetail: Codable {
    
    let foodId: String
    let catgoryId: String
    let foodImage: String
    let foodName: String
    let price: Double
    let foodScore: Int
    let description: String
    let recommended: Bool
}
