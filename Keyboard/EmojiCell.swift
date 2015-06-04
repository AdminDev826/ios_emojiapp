//
//  EmojiCell.swift
//  SportMoji
//
//  Created by Taylor Perkins on 6/4/15.
//  Copyright (c) 2015 hwrdrpkns. All rights reserved.
//

import UIKit

class EmojiCell: UICollectionViewCell {
    @IBOutlet var cellImage: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setImage(image: UIImage!) {
        cellImage?.image = image
    }
}
