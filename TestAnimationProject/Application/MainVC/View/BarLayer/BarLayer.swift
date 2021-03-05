//
//  BarLayer.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 04.03.2021.
//

import UIKit

class BarLayer: CALayer {
    
    //MARK: - Properties
    public init(frame: CGRect, backgroundColor: UIColor) {
        super.init()
        self.backgroundColor = backgroundColor.cgColor
        self.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Animation
    public func springAnimation() {
       let springAnimation = CASpringAnimation(keyPath: "bounds")
        springAnimation.initialVelocity = 0.0
        springAnimation.mass = 10.0
        springAnimation.stiffness = 500.0
        springAnimation.damping = 30.0
        springAnimation.duration = CFTimeInterval.random(in: 0.5...1.5)
        springAnimation.repeatCount = .infinity
        springAnimation.fromValue = CGRect(x: position.x, y:  position.y, width: frame.width, height: frame.height)
        springAnimation.toValue =  CGRect(x: position.x, y:  position.y, width: frame.width, height: frame.height * 1.2)
        springAnimation.autoreverses = true
        
        self.add(springAnimation, forKey: nil)
    }
    

}


extension BarLayer: CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.opacity = 1.0
    }

}
