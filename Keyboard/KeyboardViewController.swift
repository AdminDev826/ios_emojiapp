//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Taylor Perkins on 6/3/15.
//  Copyright (c) 2015 hwrdrpkns. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, KeyboardActionHandler {
    
    @IBOutlet var keyboardView: KeyboardView?
    
    static let kReuseIdentifier: String = "SPORT_MOJI_CELL"
    
    let imageNames: [String] = ["woods-fistpump", "joe-horn", "reggie-choke"]
    var pathDictionary = [NSIndexPath: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSBundle.mainBundle().loadNibNamed("KeyboardView", owner: self, options: nil)
        
        self.keyboardView?.collectionView?.registerClass(EmojiCell.self, forCellWithReuseIdentifier: KeyboardViewController.kReuseIdentifier)
        self.keyboardView?.collectionView?.delegate = self
        self.keyboardView?.collectionView?.dataSource = self
        
        self.view.addSubview(self.keyboardView!)
    }
    
    func nextKeyboardButtonClicked() {
        super.advanceToNextInputMode()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2;
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 15;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            KeyboardViewController.kReuseIdentifier, forIndexPath: indexPath) as! EmojiCell
        
        let image = UIImageView(frame: cell.frame)
        let index = Int(arc4random_uniform(UInt32(imageNames.count)))
        image.image = UIImage(named: imageNames[index])
        cell.backgroundView = image
        cell.tag = index
        pathDictionary[indexPath] = index
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if (UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            return CGSize(width: 80, height: 80)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        UIPasteboard.generalPasteboard().image = UIImage(named: imageNames[pathDictionary[indexPath]!])
    }
    
    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    }
}
