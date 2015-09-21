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
    func firstCategoryButtonClicked()
    func secondCategoryButtonClicked()
    func thirdCategoryButtonClicked()
    func miscCategoryButtonClicked()
}

@objc public class KeyboardView: UIView {
    
    var delegate: KeyboardActionHandler?
    
    @IBAction func nextKeyboardButtonClicked(sender: UIButton) {
        delegate?.nextKeyboardButtonClicked()
    }
    
    @IBAction func firstCategoryButtonClicked(sender: UIButton) {
        delegate?.firstCategoryButtonClicked()
    }
    
    @IBAction func secondCategoryButtonClicked(sender: UIButton) {
        delegate?.secondCategoryButtonClicked()
    }
    
    @IBAction func thirdCategoryButtonClicked(sender: UIButton) {
        delegate?.thirdCategoryButtonClicked()
    }
    
    @IBAction func miscCategoryButtonClicked(sender: UIButton) {
        delegate?.miscCategoryButtonClicked()
    }
}
