//
//  DoctorsModel.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 03/05/23.
//

import Foundation

struct Doctors: Codable {
    let category: String
    let items: [DoctorsByCategory]
}

struct DoctorsByCategory: Codable {
    let name: String
    let doctorNumber: String
    let specialization: String
    let experienceYear: Int
    let location: String
    let specializationDetail: String
    let previousPrice: String
    let price: String
    let doctorImg: String
    let rating: String
    let reviewCount: Int
    let reviews: [Review]
}

struct Review: Codable {
    let tag: String
    let tagCount: Int
}
