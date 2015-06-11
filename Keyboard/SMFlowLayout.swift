//
//  SMFlowLayout.swift
//  SportMoji
//
//  Created by Taylor Perkins on 6/11/15.
//  Copyright (c) 2015 hwrdrpkns. All rights reserved.
//

import UIKit

class SMFlowLayout : UICollectionViewFlowLayout {
    override func collectionViewContentSize() -> CGSize {
        if Orientation.IS_PORTRAIT {
            return CGSizeMake(3 * 100, 15 * 100)
        } else {
            return CGSizeMake(6 * 100, 15 * 100)
        }
    }
}
