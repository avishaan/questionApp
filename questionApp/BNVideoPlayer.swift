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
  let videoFileInfo:(path:String, ext:String) = ("pincer grasp", "mp4")
  
  
  var view: UIView!
  var player: MPMoviePlayerController?
  
  @IBOutlet weak var thumbnailButton: UIButton!
  
  override init(frame: CGRect) {
    // 1. setup any properties here
    
    // 2. call super.init(frame:)
    super.init(frame: frame)
    
    // 3. Setup view from .xib file
    setup()
  }
  
  required init(coder aDecoder: NSCoder) {
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
    view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
    addSubview(view)
    
    // setup thumbnail
    thumbnailButton.setBackgroundImage(thumbnailOfVideo(), forState: UIControlState.Normal)
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass:self.dynamicType)
    let nib = UINib(nibName: nibName, bundle: bundle)
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    
    return view
  }
  
  func thumbnailOfVideo() -> UIImage? {
    let videoURL = NSBundle.mainBundle().URLForResource(videoFileInfo.path, withExtension: videoFileInfo.ext)
    var err: NSError?
    let asset = AVURLAsset(URL: videoURL!, options: nil)
    let imgGenerator = AVAssetImageGenerator(asset: asset)
    let thumbnail = imgGenerator.copyCGImageAtTime(CMTimeMake(10, 1), actualTime: nil, error: &err)
    
    return UIImage(CGImage: thumbnail)
    
  }
  
  func playVideo() {
    let videoPath = NSBundle.mainBundle().pathForResource(videoFileInfo.path, ofType: videoFileInfo.ext)
    if let
      url = NSURL(fileURLWithPath: videoPath!),
      moviePlayer = MPMoviePlayerController(contentURL: url) {
        self.player = moviePlayer
        moviePlayer.view.frame = self.view.bounds
        moviePlayer.prepareToPlay()
        moviePlayer.scalingMode = .AspectFill
        self.view.addSubview(moviePlayer.view)
    } else {
      debugPrintln("Ops, something wrong when playing video.m4v")
    }
  }
  
  
  /*
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect) {
  // Drawing code
  }
  */
  
}
