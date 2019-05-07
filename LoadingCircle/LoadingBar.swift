//
//  loadingBar.swift
//  LoadingCircle
//
//  Created by Daniel Hjärtström on 2018-11-02.
//  Copyright © 2018 Sog. All rights reserved.
//

import UIKit

class LoadingBar: UIView {
    
    var completion: CGFloat = 0.0 {
        didSet {
            let percentage = Int(ceil(Double(completion)))
            animatingLayer.strokeEnd = completion / 100.0
            label.text = "\(percentage)%"
            
            if percentage == 100 {
                loadCompletion()
            }
        }
    }
    
    private lazy var startAngle = CGFloat.pi * 3.0 / 2.0
    private lazy var endAngle = startAngle + CGFloat.pi * 2
    private var lineWidth: CGFloat = 27.0
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let temp = CAShapeLayer()
        temp.strokeColor = rgb(178, green: 34, blue: 34).cgColor
        temp.fillColor = UIColor.clear.cgColor
        temp.shadowColor = UIColor.red.cgColor
        temp.shadowOffset = CGSize(width: 3, height: 3)
        temp.shadowRadius = 6
        temp.shadowOpacity = 0.8
        temp.strokeEnd = 1.0
        temp.lineWidth = lineWidth
        layer.addSublayer(temp)
        return temp
    }()
    
    private lazy var animatingLayer: CAShapeLayer = {
        let temp = CAShapeLayer()
        temp.strokeColor = UIColor.red.withAlphaComponent(0.8).cgColor
        temp.fillColor = UIColor.clear.cgColor
        temp.strokeEnd = 0
        temp.lineWidth = lineWidth
        layer.insertSublayer(temp, above: backgroundLayer)
        return temp
    }()
    
    private lazy var pulsatingLayer: CAShapeLayer = {
        let temp = CAShapeLayer()
        temp.strokeColor = UIColor.red.withAlphaComponent(0.5).cgColor
        temp.fillColor = UIColor.clear.cgColor
        temp.strokeEnd = 1.0
        temp.lineWidth = lineWidth
        layer.insertSublayer(temp, below: backgroundLayer)
        return temp
    }()
    
    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.numberOfLines = 1
        temp.text = "0%"
        temp.textAlignment = .center
        temp.textColor = UIColor.white
        temp.adjustsFontSizeToFitWidth = true
        temp.minimumScaleFactor = 0.7
        temp.font = UIFont(name: "Futura-CondensedExtraBold", size: 44.0)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureFrames()
    }
    
    private func configureFrames() {
        
        backgroundLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2 - (lineWidth / 2), startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        backgroundLayer.frame = self.bounds
        
        animatingLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2 - (lineWidth / 2), startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        animatingLayer.frame = self.bounds
        
        pulsatingLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2 - (lineWidth / 2), startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        pulsatingLayer.frame = self.bounds
        
    }
    
    private func commonInit() {
        label.isHidden = false
        puslseAnimation()
        alphaAnimation()
    }
    
    private func loadCompletion() {
        pulsatingLayer.removeAllAnimations()
        animatingLayer.strokeColor = backgroundLayer.strokeColor
        animatingLayer.strokeEnd = 0
        animatingLayer.strokeColor = UIColor.green.withAlphaComponent(0.9).cgColor
        animateCompletion()
    }
}


extension LoadingBar {
    
    private func animateCompletion() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.backgroundLayer.shadowColor = UIColor.green.cgColor
        }
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1.5
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animatingLayer.add(animation, forKey: CAShapeLayer.AnimationKeys.completion)
        
        CATransaction.commit()
    }
    
    private func puslseAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.0
        animation.toValue = 1.1
        animation.autoreverses = true
        animation.duration = 1.5
        animation.repeatCount = .infinity
        pulsatingLayer.add(animation, forKey: CAShapeLayer.AnimationKeys.pulse)
    }
    
    private func alphaAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.autoreverses = true
        animation.duration = 1.5
        animation.repeatCount = .infinity
        pulsatingLayer.add(animation, forKey: CAShapeLayer.AnimationKeys.opacity)
    }
    
}
