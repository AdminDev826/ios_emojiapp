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

    @IBAction func goToSettingsClicked(_ sender: UIButton) {
        let application = UIApplication.shared
        application.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    }

    @IBAction func rateThisAppClicked(_ sender: UIButton) {
        let appId = "1045427627"
        let url = "itms-apps://itunes.apple.com/app/id\(appId)"
        UIApplication.shared.openURL(URL(string: url)!)
    }

    override func viewDidLoad() {
        let path = Bundle.main.path(forResource: "doji_video", ofType: "mov")
        let url = URL(fileURLWithPath: path!);

        self.moviePlayer = MPMoviePlayerController.init(contentURL: url);
        self.moviePlayer.prepareToPlay();
        self.moviePlayer.repeatMode = MPMovieRepeatMode.none

        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.moviePlayerDidFinish(_:)), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: self.moviePlayer)

        self.videoContainer.addSubview(self.moviePlayer.view)
    }

    override func viewDidLayoutSubviews() {
        self.moviePlayer.view.frame = videoContainer.bounds
        self.moviePlayer.play()
    }

    func moviePlayerDidFinish(_ notif: Notification) {
        if notif.object as! MPMoviePlayerController == self.moviePlayer {
            let object = notif.userInfo![MPMoviePlayerPlaybackDidFinishReasonUserInfoKey]
            let reason = object as! NSInteger
            if MPMovieFinishReason.playbackEnded == MPMovieFinishReason.init(rawValue: reason) {
                self.moviePlayer.play()
            }
        }
    }
}

