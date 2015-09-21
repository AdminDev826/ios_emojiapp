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
    
    @IBOutlet var keyboardView: KeyboardView!
    var collectionView: UICollectionView!
    
    static let kReuseIdentifier: String = "SportMojiCell"
    
    let imageNames: [String] = ["woods-fistpump", "joe-horn", "reggie-choke"]
    var pathDictionary = [NSIndexPath: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSBundle.mainBundle().loadNibNamed("KeyboardView", owner: self, options: nil)
        self.keyboardView?.delegate = self
        
        collectionView = UICollectionView(frame: CGRect(origin: CGPoint(x: 35, y: 0), size: CGSize(width: self.view.frame.width - 35, height: self.view.frame.height)))
        
        collectionView.delegate = self
        collectionView.registerClass(EmojiCell.self, forCellWithReuseIdentifier: KeyboardViewController.kReuseIdentifier)
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        self.view.addSubview(keyboardView)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func firstCategoryButtonClicked() {
        collectionView.reloadData()
    }
    
    func secondCategoryButtonClicked() {
        collectionView.reloadData()
    }
    
    func thirdCategoryButtonClicked() {
        collectionView.reloadData()
    }
    
    func miscCategoryButtonClicked() {
        collectionView.reloadData()
    }
    
    func nextKeyboardButtonClicked() {
        super.advanceToNextInputMode()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Orientation.IS_PORTRAIT ? 3 : 6
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 15;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            KeyboardViewController.kReuseIdentifier, forIndexPath: indexPath)
        
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
        return Orientation.IS_PORTRAIT ? CGSize(width: 80, height: 80) : CGSize(width: 100, height: 100)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        UIPasteboard.generalPasteboard().persistent = true
        UIPasteboard.generalPasteboard().image = UIImage(named: imageNames[pathDictionary[indexPath]!])
    }
}
