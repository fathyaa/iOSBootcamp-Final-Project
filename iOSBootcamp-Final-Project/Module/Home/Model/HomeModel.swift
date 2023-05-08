//
//  ProductModel.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import Foundation

struct Home: Codable {
    let pageSection: String
    let items: [Items]
}

struct Items: Codable {
    let thumbnailImg: String
    let title: String
    let category: String
}
