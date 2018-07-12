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
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        let iconHeight: CGFloat = 38
        let padding: CGFloat = 6
        let images = [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "surprised"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "cry"), #imageLiteral(resourceName: "angry")]

        let arrangedSubviews = images.map({ (image) -> UIImageView in
            let iv = UIImageView()
            iv.image = image
            iv.layer.cornerRadius = iconHeight / 2
            //require for hit testing
            iv.isUserInteractionEnabled = true
            return iv
        })
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        containerView.addSubview(stackView)

        let numIcons = CGFloat(arrangedSubviews.count)
        let containerWidth = numIcons * iconHeight + (numIcons + 1) * padding
        
        containerView.frame = CGRect(x: 0, y: 0, width: containerWidth, height: iconHeight + 2 * padding)
        containerView.layer.cornerRadius = containerView.frame.height / 2
        containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        stackView.frame = containerView.frame

        return containerView
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

