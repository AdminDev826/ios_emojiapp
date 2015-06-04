//
//  KeyboardView.swift
//  SportMoji
//
//  Created by Taylor Perkins on 6/4/15.
//  Copyright (c) 2015 hwrdrpkns. All rights reserved.
//

import UIKit

protocol KeyboardActionHandler {
    func nextKeyboardButtonClicked()
}

@objc public class KeyboardView: UIView {
    
    var delegate: KeyboardActionHandler?
    @IBOutlet var collectionView: UICollectionView?
    
    @IBAction func nextKeyboardButtonClicked(sender: UIButton) {
        delegate?.nextKeyboardButtonClicked()
    }
}
