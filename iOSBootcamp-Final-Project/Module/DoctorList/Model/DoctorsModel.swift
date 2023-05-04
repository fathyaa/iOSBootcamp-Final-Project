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
    let nama: String
    let noDokter: String
    let spesialis: String
    let tahunPengalaman: Int
    let lokasi: String
    let detailSpesialisasi: String
    let previousPrice: String
    let price: String
    let doctorImg: String
}
