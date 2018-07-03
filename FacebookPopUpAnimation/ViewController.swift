//
//  ViewController.swift
//  FacebookPopUpAnimation
//
//  Created by SEAN on 2018/7/3.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "fb_core_data_bg")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let iconsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.frame.size.width = 200
        view.frame.size.height = 100
//        view.frame = CGRect(x: 0, y: 0, width: 200, height: 100)

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.frame = view.frame
        
        setupLongPressGesture()
        
    }
    
    override var prefersStatusBarHidden: Bool { return true }

    fileprivate func setupLongPressGesture(){
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    @objc private func handleLongPress(gesture: UILongPressGestureRecognizer){
        
        if gesture.state == .began{
            handleGestureBegan(gesture: gesture)
            
        }else if gesture.state == .ended{
            iconsContainerView.removeFromSuperview()
        }
    }
    
    fileprivate func handleGestureBegan(gesture: UILongPressGestureRecognizer){
        view.addSubview(iconsContainerView)
        
        let pressedLocation = gesture.location(in: view)
        let centeredX = (view.frame.width - iconsContainerView.frame.width) / 2
        
        iconsContainerView.frame.origin = CGPoint(x: centeredX, y: pressedLocation.y)
        //            iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        
        iconsContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.iconsContainerView.alpha = 1
            
            self.iconsContainerView.frame.origin = CGPoint(x: centeredX, y: pressedLocation.y - self.iconsContainerView.frame.height)
            //               self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - - self.iconsContainerView.frame.height)
            
        }, completion: nil)
        
    }
    
}

