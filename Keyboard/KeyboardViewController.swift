//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Taylor Perkins on 6/3/15.
//  Copyright (c) 2015 hwrdrpkns. All rights reserved.
//

import UIKit
import QuartzCore

class KeyboardViewController: UIInputViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, KeyboardActionHandler {
    
    @IBOutlet var keyboardView: KeyboardView?
    
    static let kReuseIdentifier: String = "SPORT_MOJI_CELL"
    
    let imageNames: [String] = ["woods-fistpump", "joe-horn", "reggie-choke"]
    var pathDictionary = [NSIndexPath: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSBundle.mainBundle().loadNibNamed("KeyboardView", owner: self, options: nil)
        
        self.keyboardView?.collectionView?.registerClass(EmojiCell.self, forCellWithReuseIdentifier: KeyboardViewController.kReuseIdentifier)
        self.keyboardView?.delegate = self
        
        self.view.addSubview(self.keyboardView!)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        keyboardView?.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func nextKeyboardButtonClicked() {
        super.advanceToNextInputMode()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Orientation.IS_PORTRAIT ? 3 : 6
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
        pathDictionary[indexPath] = index
        
        if Build.DEBUG {
            cell.contentView.layer.borderColor = UIColor.redColor().CGColor
            cell.contentView.layer.borderWidth = 1.0
        }
        
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
        println("Selected index path \(indexPath)")
        UIPasteboard.generalPasteboard().persistent = true
        UIPasteboard.generalPasteboard().image = UIImage(named: imageNames[pathDictionary[indexPath]!])
    }
}