//
//  Loader.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 29/07/2022.
//

import UIKit
import Lottie

class Loader: NSObject {
    
    static var overlayView: UIView!
    static var animationView: AnimationView?
    
    static func dismissLoading(){
         DispatchQueue.main.async {
            animationView?.stop()
            animationView?.removeFromSuperview()
            guard overlayView != nil else { return }
            overlayView.removeFromSuperview()
        }
    }
 
    static func showLoading(_ view:UIView){
        dismissLoading()
        DispatchQueue.main.async {
            overlayView = UIView(frame: UIScreen.main.bounds)
            overlayView.tag = 24111994
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            view.addSubview(overlayView)
            animationView = .init(name: "loading")
            animationView!.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            animationView?.center = overlayView.center
            animationView!.contentMode = .scaleAspectFit
            animationView!.loopMode = .loop
            animationView!.animationSpeed = 1
            overlayView.addSubview(animationView!)
            animationView!.play()
        }
    }

}




