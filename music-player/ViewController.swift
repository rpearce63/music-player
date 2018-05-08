//
//  ViewController.swift
//  music-player
//
//  Created by Rick on 5/7/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class ViewController: UIViewController, MPMediaPickerControllerDelegate {

    @IBOutlet weak var nowPlayingLbl : UILabel!
    var mediaPicker: MPMediaPickerController?
    var musicPlayer: MPMusicPlayerController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        musicPlayer = MPMusicPlayerController.applicationMusicPlayer
        if let player = musicPlayer {
            player.beginGeneratingPlaybackNotifications()
            player.setQueue(with: mediaItemCollection)
            player.play()
            self.updateNowPlayingItem()
            
            mediaPicker.dismiss(animated: true, completion: nil)
        }
    }
    
    func displayMediaPickerAndPlayItem() {
        mediaPicker = MPMediaPickerController(mediaTypes: .anyAudio)
        
        if let picker = mediaPicker {
            print("Successuflly instantiated a media picker")
            picker.delegate = self
            view.addSubview(picker.view)
            present(picker, animated: true, completion: nil)
        } else {
            print("Could not instantiate a media  picker")
        }
    }
    
    func updateNowPlayingItem() {
        if let nowPlayingItem = self.musicPlayer!.nowPlayingItem {
            let nowPlayingTitle = nowPlayingItem.title
            self.nowPlayingLbl.text = nowPlayingTitle
        } else {
            self.nowPlayingLbl.text = "Nothing Played"
        }
    }
    
    

    @IBAction func openItunesBtnPressed(_ sender: Any) {
        displayMediaPickerAndPlayItem()
    }
    
}

