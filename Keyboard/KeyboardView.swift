//
//  KeyboardView.swift
//  SportMoji
//
//  Created by Taylor Perkins on 6/4/15.
//  Copyright (c) 2015 hwrdrpkns. All rights reserved.
//

import UIKit

protocol KeyboardActionHandler {
    func deleteButtonClicked()
    func nextKeyboardButtonClicked()
    func firstCategoryButtonClicked()
    func secondCategoryButtonClicked()
    func miscCategoryButtonClicked()
}

@objc open class KeyboardView: UIView {
    
    var delegate: KeyboardActionHandler?
    
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var nextKeyboardButton: UIButton!
    
    @IBAction func nextKeyboardButtonClicked(_ sender: UIButton) {
        delegate?.nextKeyboardButtonClicked()
    }
    
    @IBAction func firstCategoryButtonClicked(_ sender: UIButton) {
        delegate?.firstCategoryButtonClicked()
    }
    
    @IBAction func secondCategoryButtonClicked(_ sender: UIButton) {
        delegate?.secondCategoryButtonClicked()
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        delegate?.deleteButtonClicked()
    }
    
    @IBAction func miscCategoryButtonClicked(_ sender: UIButton) {
        delegate?.miscCategoryButtonClicked()
    }
}
