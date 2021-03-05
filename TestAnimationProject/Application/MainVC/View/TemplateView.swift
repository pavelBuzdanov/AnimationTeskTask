//
//  PulseView.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import UIKit
 
//MARK: - TemplateViewDelegate
protocol  TemplateViewDelegate: class {
    func deleteView()
}

class TemplateView: UIView {
    
    
    //MARK: - Properties
    
    weak var delegate: TemplateViewDelegate?
    
    var image: UIImage?  {
        didSet {
            if let image = image {
                self.imageView.image = image
            }
        }
    }
    
    var isOnTheScreen = false {
        didSet{
            if self.isOnTheScreen {
                self.alpha = 1
                setupBars()
                appearAnimation()
            } else {
                self.alpha = 0
            }
        }
    }
    
    
    private let barHeights = [20, 40, 80, 160, 250, 300, 220, 150, 100 , 80, 170, 260, 140, 80, 20]

    private let templateLayer = CALayer()
    
    private let barWidth: CGFloat = 10
    
    private let templateRightOffset: CGFloat = 25
    
    private let firstBarOffset: CGFloat = 5
    
    
    private var barsCount: Int {
        return barHeights.count
    }
    
    
    //MARK: - View
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var trashButton: UIButton = {
       let button = UIButton()
        button.frame = CGRect(x: templateLayer.frame.width-15, y: 25, width: 30, height: 30)
        button.setImage(UIImage(named: "trash"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func draw(_ rect: CGRect) {
        templateLayer.frame = CGRect(x: 20, y: 20, width: rect.width - 40 , height: rect.height * 0.95)
        templateLayer.backgroundColor = UIColor.white.cgColor
        
        self.layer.addSublayer(templateLayer)
        addSubview(trashButton)
    }
    
    
    //MARK: - SetupView
    private func setupView() {
        backgroundColor = .clear
        self.alpha = 0
    }
    
    //MARK: - Setup Bars
    private func setupBars() {
        let maskLayer = CALayer()
        maskLayer.frame = imageView.bounds
        maskLayer.backgroundColor = UIColor.clear.cgColor
        
        var offset = firstBarOffset + templateRightOffset
        
        imageView.frame = self.bounds
        addSubview(imageView)
        
        let spacing = (templateLayer.bounds.size.width - firstBarOffset)/CGFloat(barsCount)
        
        for height in barHeights {
            let height: CGFloat = CGFloat(height)
            
            let frame = CGRect(x: offset, y: imageView.bounds.height/2 - height/2 , width: barWidth, height: height)
            
            let layer = BarLayer(frame: frame, backgroundColor: .green)
            layer.opacity = 0.0
            layer.springAnimation()
            maskLayer.addSublayer(layer)
            offset += spacing
        }
        
        
        imageView.layer.mask = maskLayer
        imageView.layer.masksToBounds = true
        
        guard let sublayers = maskLayer.sublayers else { return }
        guard let middleIndex = sublayers.firstIndex(of: sublayers.middle!) else { return }
        
        let endLayers = sublayers.suffix(middleIndex)
       
        let startLayers = sublayers.prefix(upTo: middleIndex+1)
       
        var timeOffset:Double = 0
        let delay:Double =  0.01
        
        for layer in endLayers {
            addBarOpacityAnimation(layer: layer, timeOffset: timeOffset)
            timeOffset += 0.1 + delay
        }
        
        timeOffset = 0
        
        
        for layer in startLayers.reversed() {
            addBarOpacityAnimation(layer: layer, timeOffset: timeOffset)
            timeOffset += 0.1 + delay
        }
    }

    //MARK: - Animations
    @objc private func trashButtonTapped() {
        delegate?.deleteView()
    }
    
    private func appearAnimation() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        scaleAnimation.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(1.5, 1.5, 1.5))
        scaleAnimation.toValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnimation.duration = 0.5
        scaleAnimation.isRemovedOnCompletion = true
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        self.layer.add(scaleAnimation, forKey: "scaleAniation")
    }
    
    
    private func addBarOpacityAnimation(layer: CALayer,timeOffset: TimeInterval) {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.0
        opacityAnimation.toValue = 1.0
        opacityAnimation.fillMode = .forwards
        opacityAnimation.beginTime = CACurrentMediaTime() + timeOffset
        opacityAnimation.duration = 0.3
        opacityAnimation.isRemovedOnCompletion = false
        layer.add(opacityAnimation, forKey: "opacity")
    }
}


//MARK: - Extension
extension Array {

    var middle: Element? {
        guard count != 0 else { return nil }

        let middleIndex = (count > 1 ? count - 1 : count) / 2
        return self[middleIndex]
    }

}



