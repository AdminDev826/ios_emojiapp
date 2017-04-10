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
    var toastView: UIView!
    
    static let kReuseIdentifier: String = "SportMojiCell"
    
    var pathDictionary = [IndexPath: Int]()
    var currentImages = EmojiDefs.basketballImages
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if KeyboardViewController.hasFullAccess() {
            Bundle.main.loadNibNamed("KeyboardView", owner: self, options: nil)
            self.view.addSubview(keyboardView)
            self.keyboardView.delegate = self
        } else {
            Bundle.main.loadNibNamed("GrantAccessView", owner: self, options: nil)
            self.view.addSubview(grantAccessView)
        }
    }
    
    @IBAction func grantShareDojiButtonClicked(_ sender: UIButton) {
        let appId = "com.hwrdprkns.SportMoji"
        let url = "itms-apps://itunes.apple.com/app/id\(appId)"
        self.textDocumentProxy.insertText("Take a look at Doji! \(url)")
    }

    @IBAction func grantNextKeyboardButtonClicked(_ sender: UIButton) {
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
        collectionView.backgroundColor = UIColor.white
        
        collectionView.delegate = self
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: KeyboardViewController.kReuseIdentifier)
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        toastView = UIView(frame: collectionView.frame)
        toastView.backgroundColor = UIColor.clear
        toastView.isUserInteractionEnabled = false
        self.view.addSubview(toastView)
        self.keyboardView.deleteButton.isHidden = isLandscape()
    }
    
    func isLandscape() -> Bool {
        return UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height
    }
    
    func firstCategoryButtonClicked() {
        currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.basketball)
        collectionView.reloadData()
    }
    
    func secondCategoryButtonClicked() {
        currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.football)
        collectionView.reloadData()
    }
    
    func deleteButtonClicked() {
        // Delete backward twice becuase there is a newline
        // after the image is pasted into the label.
        self.textDocumentProxy.deleteBackward()
        self.textDocumentProxy.deleteBackward()
    }
    
    func miscCategoryButtonClicked() {
        currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.misc)
        collectionView.reloadData()
    }
    
    func nextKeyboardButtonClicked() {
        super.advanceToNextInputMode()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: KeyboardViewController.kReuseIdentifier, for: indexPath)
        
        let image = UIImageView(frame: cell.frame)
        let name = self.currentImages[indexPath.row + indexPath.section]
        let uiimage = UIImage(named: "\(name)_thumb")
        image.image = uiimage
        cell.backgroundView = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as UICollectionViewCell!
        cell?.backgroundColor = UIColor.gray
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as UICollectionViewCell!
        cell?.backgroundColor = UIColor.white
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        UIPasteboard.general.isPersistent = true
        let imageName = currentImages[indexPath.row + indexPath.section]
        let image = UIImage(named: imageName)!
        self.toastView.makeToast("Doji copied. Now paste it!")

        UIPasteboard.general.image = scaleImageDown(image, scale: 0.85)
    }
    
    func scaleImageDown(_ image: UIImage, scale: CGFloat) -> UIImage {
        let size = image.size.applying(CGAffineTransform(scaleX: scale, y: scale))
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
    static func hasFullAccess() -> Bool {
        return UIPasteboard.general.isKind(of: UIPasteboard.self)
    }
}
