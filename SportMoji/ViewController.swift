//
//  ViewController.swift
//  SportMoji
//
//  Created by Taylor Perkins on 6/3/15.
//  Copyright (c) 2015 hwrdrpkns. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet var videoContainer: UIView!

    var moviePlayer: MPMoviePlayerController!

    @IBAction func goToSettingsClicked(sender: UIButton) {
        let application = UIApplication.sharedApplication()
        application.openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
    }

    @IBAction func rateThisAppClicked(sender: UIButton) {
        let appId = "com.hwrdprkns.SportMoji"
        let url = "itms-apps://itunes.apple.com/app/id\(appId)"
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    @IBOutlet var labelView: UITextField!

    override func viewDidLoad() {
        let path = NSBundle.mainBundle().pathForResource("doji_video", ofType: "mov")
        let url = NSURL.fileURLWithPath(path!);

        self.moviePlayer = MPMoviePlayerController.init(contentURL: url);
        self.moviePlayer.prepareToPlay();
        self.moviePlayer.repeatMode = MPMovieRepeatMode.None

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerDidFinish:", name: MPMoviePlayerPlaybackDidFinishNotification, object: self.moviePlayer)

        self.videoContainer.addSubview(self.moviePlayer.view)
    }

    override func viewDidLayoutSubviews() {
        self.moviePlayer.view.frame = videoContainer.bounds
        self.moviePlayer.play()
    }

    func moviePlayerDidFinish(notif: NSNotification) {
        if notif.object as! MPMoviePlayerController == self.moviePlayer {
            let object = notif.userInfo![MPMoviePlayerPlaybackDidFinishReasonUserInfoKey]
            let reason = object as! NSInteger
            if MPMovieFinishReason.PlaybackEnded == MPMovieFinishReason.init(rawValue: reason) {
                self.moviePlayer.play()
            }
        }
    }
}

