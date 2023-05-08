//
//  AccountModel.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import Foundation

struct Account: Codable {
    let menuSection: String
    let items: [AccountItems]
}

struct AccountItems: Codable {
    let iconImg: String?
    let title: String
    let subtitle: String
}

struct User: Codable {
    let name: String
    let email: String
    let userUID: String
}
