//
//  EmojiDefs.swift
//  SportMoji
//
//  Created by Taylor Perkins on 9/22/15.
//  Copyright © 2015 hwrdrpkns. All rights reserved.
//

import Foundation

struct EmojiDefs {
    enum Categories { case Basketball, Football, Baseball, Misc }

    static func imageForCategory(category: Categories) -> [String] {
        switch(category) {
        case .Basketball:
            return basketballImages
        case .Football:
            return footballImages
        case .Misc:
            return miscImages
        default:
            return miscImages
        }
    }

    static let basketballImages: [String] = [
        "iverson",
        "james_harden",
        "jordan_trophy",
        "lance_stephenson",
        "lebron_james",
        "michael_jordan",
        "mutumbo",
        "reggie_miller",
        "spurs_trio",
        "wilt"
    ]

    static let footballImages: [String] = [
        "cam_newton",
        "joe_horn",
        "johnny_manziel",
        "kevin_dyson",
        "owens",
        "randy_moss",
        "ray_lewis",
        "tim_tebow",
        "tony_gonzalez"
    ]

    static let miscImages: [String] = [
        "ali",
        "bolt",
        "bruce_jenner",
        "diego_maradona",
        "john_mcenroe",
        "lance_armstrong",
        "wilt",
        "woods",
        "derek_jeter",
        "kirk_gibson",
        "mike_trout"
    ]
}
