//
//  GraphView.swift
//  Flo
//
//  Created by Jess Gates on 5/9/17.
//  Copyright © 2017 Jess Gates. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {

    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        var path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()
        
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)
        
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0.0, y: bounds.height)
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [])}

}
