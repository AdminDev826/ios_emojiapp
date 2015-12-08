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
    @IBOutlet var grantAccessView: UIView!
    var collectionView: UICollectionView!
    
    static let kReuseIdentifier: String = "SportMojiCell"
    
    var pathDictionary = [NSIndexPath: Int]()
    var currentImages = EmojiDefs.basketballImages
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if KeyboardViewController.hasFullAccess() {
            NSBundle.mainBundle().loadNibNamed("KeyboardView", owner: self, options: nil)
            self.view.addSubview(keyboardView)
            self.keyboardView.delegate = self
        } else {
            NSBundle.mainBundle().loadNibNamed("GrantAccessView", owner: self, options: nil)
            self.view.addSubview(grantAccessView)
        }
    }
    
    @IBAction func grantNextKeyboardButtonClicked(sender: UIButton) {
        nextKeyboardButtonClicked()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if keyboardView == nil {
            return
        }
        
        let rect = CGRect(origin: CGPoint(x: 35, y: 0), size: CGSize(width: self.view.frame.width - 35, height: self.view.frame.height))
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        collectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.delegate = self
        collectionView.registerClass(EmojiCell.self, forCellWithReuseIdentifier: KeyboardViewController.kReuseIdentifier)
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        self.keyboardView.deleteButton.hidden = isLandscape()
    }
    
    func isLandscape() -> Bool {
        return UIScreen.mainScreen().bounds.size.width > UIScreen.mainScreen().bounds.size.height
    }
    
    func firstCategoryButtonClicked() {
        currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.Basketball)
        collectionView.reloadData()
    }
    
    func secondCategoryButtonClicked() {
        currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.Football)
        collectionView.reloadData()
    }
    
    func deleteButtonClicked() {
        // Delete backward twice becuase there is a newline
        // after the image is pasted into the label.
        self.textDocumentProxy.deleteBackward()
        self.textDocumentProxy.deleteBackward()
    }
    
    func miscCategoryButtonClicked() {
        currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.Misc)
        collectionView.reloadData()
    }
    
    func nextKeyboardButtonClicked() {
        super.advanceToNextInputMode()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentImages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            KeyboardViewController.kReuseIdentifier, forIndexPath: indexPath)
        
        let image = UIImageView(frame: cell.frame)
        let name = self.currentImages[indexPath.row + indexPath.section]
        let uiimage = UIImage(named: "\(name)_thumb")
        image.image = uiimage
        cell.backgroundView = image
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as UICollectionViewCell!
        cell.backgroundColor = UIColor.grayColor()
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as UICollectionViewCell!
        cell.backgroundColor = UIColor.whiteColor()
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        UIPasteboard.generalPasteboard().persistent = true
        let imageName = currentImages[indexPath.row + indexPath.section]
        let image = UIImage(named: imageName)!

        UIPasteboard.generalPasteboard().image = scaleImageDown(image, scale: 0.85)
    }
    
    func scaleImageDown(image: UIImage, scale: CGFloat) -> UIImage {
        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(scale, scale))
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    static func hasFullAccess() -> Bool {
        return UIPasteboard.generalPasteboard().isKindOfClass(UIPasteboard)
    }
}
