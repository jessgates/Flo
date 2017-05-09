//
//  PushButtonView.swift
//  Flo
//
//  Created by Jess Gates on 5/5/17.
//  Copyright © 2017 Jess Gates. All rights reserved.
//

import UIKit
@IBDesignable

class PushButtonView: UIButton {
    
    @IBInspectable var fillColor: UIColor = .green
    @IBInspectable var isAddButton: Bool = true

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        var path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        var plusPath = UIBezierPath()
        plusPath.lineWidth = plusHeight
        
        plusPath.move(to: CGPoint(x: bounds.width/2 - plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))
        
        plusPath.addLine(to: CGPoint(x:bounds.width/2 + plusWidth/2 + 0.5, y:bounds.height/2 + 0.5))
        
        if isAddButton {
            plusPath.move(to: CGPoint(x:bounds.width/2 + 0.5, y:bounds.height/2 - plusWidth/2 + 0.5))
        
            plusPath.addLine(to: CGPoint(x:bounds.width/2 + 0.5, y:bounds.height/2 + plusWidth/2 + 0.5))
        }
        
        UIColor.white.setStroke()
        plusPath.stroke()
    }
}
