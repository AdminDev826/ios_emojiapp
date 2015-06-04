//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Taylor Perkins on 6/3/15.
//  Copyright (c) 2015 hwrdrpkns. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var keyboardView: KeyboardView?
    
    static var kReuseIdentifier: String = "SPORT_MOJI_CELL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSBundle.mainBundle().loadNibNamed("KeyboardView", owner: self, options: nil)
        
        self.keyboardView?.collectionView?.registerClass(EmojiCell.self, forCellWithReuseIdentifier: KeyboardViewController.kReuseIdentifier)
        self.keyboardView?.collectionView?.delegate = self
        self.keyboardView?.collectionView?.dataSource = self
        
        self.view.addSubview(self.keyboardView!)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            KeyboardViewController.kReuseIdentifier, forIndexPath: indexPath) as! EmojiCell
        
        cell.setImage(UIImage(named: "woods-fistpump"))
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        UIPasteboard.generalPasteboard().image = UIImage(named: "woods-fistpump");
    }
    
    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    }
}
