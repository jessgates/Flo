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
    
    var graphPoints:[Int] = [4, 2, 6, 4, 5, 8, 3]
    
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
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [])
        
        let margin: CGFloat = 20.0
        var columnXpoint = { (column:Int) -> CGFloat in
            let spacer = (width - margin * 2 - 4) / CGFloat((self.graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()
        var columnYPoint = { (graphPoint:Int) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) /
                CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y // Flip the graph
            return y
        }
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
        

        var graphPath = UIBezierPath()

        graphPath.move(to: CGPoint(x:columnXpoint(0),
                                      y:columnYPoint(graphPoints[0])))
        
        //add points for each item in the graphPoints array
        //at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x:columnXpoint(i),
                                    y:columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        //CGontextSaveGState(context)
        
        var clippingPath = graphPath.copy() as! UIBezierPath
        
        clippingPath.addLine(to: CGPoint(x: columnXpoint(graphPoints.count - 1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXpoint(0), y: height))
        clippingPath.close()
        
        clippingPath.addClip()
        
        let highestPoint = columnYPoint(maxValue!)
        startPoint = CGPoint(x: margin, y: highestPoint)
        endPoint = CGPoint(x: margin, y: self.bounds.height)
        
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        //CGContextRestoreGState(context)
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
    }
}
