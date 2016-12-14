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
        "iverson_lue",
        "james_harden",
        "mj_trophy",
        "lance_steph",
        "lebron",
        "jordan_jump",
        "mutombo",
        "reggie_miller",
        "spurs_trio",
        "wilt_chamberlain",
        "kidd_kiss",
        "wbbr",
        "draymond_green_flex",
        "lebron_wade_SECOND_VERSION_in_case_red_is_too_much",
        "awing",
        "vince",
        "i_basket2"
    ]

    static let footballImages: [String] = [
        "cam_newton",
        "joe_horn",
        "joe_namath",
        "kevin_dyson",
        "terrell_owens",
        "randy_moss",
        "ray_lewis",
        "tebow",
        "tony_gonzalez",
        "bradying",
        "lynch",
        "desmond_howard",
        "brown",
        "rodgers",
        "MoneyManziel"
    ]

    static let miscImages: [String] = [
        "muhammad_ali",
        "usain_bolt",
        "bruce_jenner",
        "maradona",
        "mc_enroe",
        "lance_armstrong",
        "tiger_woods",
        "derek_jeter",
        "kirk_gibson",
        "mike_trout",
        "bautista_flip",
        "rousey",
        "chastain",
        "gretzky_99",
        "jtsnow",
        "odor",
        "serena"
    ]
}
