//
//  MenuItem.swift
//  LittleLemonFoodOrderingApp
//
//  Created by doxuto on 07/03/2023.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    let detail: String

    enum CodingKeys: String, CodingKey {
        case title
        case price
        case image
        case detail = "description"
    }
}
