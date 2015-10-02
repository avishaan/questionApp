//
//  BNVideoPlayer.swift
//  questionApp
//
//  Created by Brown Magic on 9/25/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//
import UIKit
import MediaPlayer
import AVFoundation

@IBDesignable class BNVideoPlayer: UIView {
  let nibName = "BNVideoPlayer"
  var videoFileInfo:(path:String, ext:String) = ("hearing", "mp4")
  
  
  var view: UIView!
  var player: MPMoviePlayerController?
  var time: Int!
  @IBOutlet weak var previewThumbnail: UIImageView!
  @IBOutlet weak var playButton: UIButton!
  
  @IBInspectable var videoFileName: String = "pincer grasp" {
    didSet {
      #if !TARGET_INTERFACE_BUILDER
        videoFileInfo.path = videoFileName
        // this code will run in the app itself
      #else
        // this code will execute only in IB
      #endif

    }
  }
  @IBInspectable var videoTime: Int32 = 0 {
    didSet {
      #if !TARGET_INTERFACE_BUILDER
        // this code will run in the app itself
        thumbnailOfVideo(time: videoTime)
      #else
        // this code will execute only in IB
      #endif

    }
  }
  override init(frame: CGRect) {
    // 1. setup any properties here
    
    // 2. call super.init(frame:)
    super.init(frame: frame)
    
    // 3. Setup view from .xib file
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    // 1. setup any properties here
    
    // 2. call super.init(coder:)
    super.init(coder: aDecoder)
    
    // 3. Setup view from .xib file
    setup()
  }
  /*
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect) {
  // Drawing code
  }
  */
  func setup(){
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
    addSubview(view)
    // setup thumbnail
//    thumbnailOfVideo(time)
    previewThumbnail.userInteractionEnabled = true
    // add gesture recog since the button overlay trick isn't working for some reason
    let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap"))
    view.addGestureRecognizer(tap)
    
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass:self.dynamicType)
    let nib = UINib(nibName: nibName, bundle: bundle)
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    
    return view
  }
  
  func thumbnailOfVideo(time time: Int32 = 0){
    let time = Int64(time)
    let videoURL = NSBundle.mainBundle().URLForResource(videoFileInfo.path, withExtension: videoFileInfo.ext)
    let asset = AVURLAsset(URL: videoURL!, options: nil)
    let imgGenerator = AVAssetImageGenerator(asset: asset)
    do {
      let thumbnail = try imgGenerator.copyCGImageAtTime(CMTimeMake(time, 1), actualTime: nil)
      previewThumbnail.image = UIImage(CGImage: thumbnail)
    }
    catch {
    }
  }
  
  func playVideo() {
    let videoPath = NSBundle.mainBundle().pathForResource(videoFileInfo.path, ofType: videoFileInfo.ext)
    let url = NSURL(fileURLWithPath: videoPath!)
    if let moviePlayer = MPMoviePlayerController(contentURL: url) {
        self.player = moviePlayer
        moviePlayer.view.frame = self.view.bounds
        moviePlayer.prepareToPlay()
        moviePlayer.scalingMode = .AspectFill
        self.view.addSubview(moviePlayer.view)
        moviePlayer.fullscreen = true
    } else {
      debugPrint("Ops, something wrong when playing video.m4v")
    }
  }
  
  deinit {
    self.player?.stop()
  }
  
  func handleTap() {
   print("handle tap")
  }
  
  @IBAction func onPlayTap(sender: AnyObject) {
    // hide button
    playButton.hidden = true
    // hide preview
    previewThumbnail.hidden = true
    // play video
    playVideo()
    
  }
  
  /*
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect) {
  // Drawing code
  }
  */
  
}
