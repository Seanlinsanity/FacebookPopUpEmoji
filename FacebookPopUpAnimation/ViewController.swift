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
    
    let iconsContainerView: IconsContainerView = {
        let iconsContainerView = IconsContainerView()
        return iconsContainerView
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
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                self.iconsContainerView.alpha = 0
                self.iconsContainerView.transform = self.iconsContainerView.transform.translatedBy(x: 0, y: 50)
                
            }, completion: {(_) in
                self.iconsContainerView.removeFromSuperview()
            })
            
        }else if gesture.state == .changed {
            handleGestureChanged(gesture: gesture)
        }
    }
    
    fileprivate func handleGestureChanged(gesture: UILongPressGestureRecognizer){
        let pressedLoaction = gesture.location(in: iconsContainerView)
        print(pressedLoaction)
        let fixedYLocation = CGPoint(x: pressedLoaction.x, y: self.iconsContainerView.frame.height / 2)
        
        let hitTestView = iconsContainerView.hitTest(fixedYLocation, with: nil)
        
        if hitTestView is UIImageView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
                
            }, completion: nil)
        }
        
    }
    
    fileprivate func handleGestureBegan(gesture: UILongPressGestureRecognizer){
        view.addSubview(iconsContainerView)
        iconsContainerView.frame = CGRect(x: 0, y: 0, width: iconsContainerView.containerWidth ?? 0, height: iconsContainerView.containerHeight ?? 0)
        
        let pressedLocation = gesture.location(in: view)
        let centeredX = (view.frame.width - iconsContainerView.frame.width) / 2
        
        iconsContainerView.frame.origin = CGPoint(x: centeredX, y: pressedLocation.y)
        //            iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        
        iconsContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.iconsContainerView.alpha = 1
            
            self.iconsContainerView.frame.origin = CGPoint(x: centeredX, y: pressedLocation.y - self.iconsContainerView.frame.height)
            //               self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.iconsContainerView.frame.height)
            
        }, completion: nil)
        
    }
    
}

