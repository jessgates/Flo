//
//  ViewController.swift
//  Flo
//
//  Created by Jess Gates on 5/5/17.
//  Copyright © 2017 Jess Gates. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var medalView: MedalView!
    
    var isGraphViewShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        counterLabel.text = String(counterView.counter)
        checkTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkTotal() {
        if counterView.counter >= 8 {
            medalView.showMedal(show: true)
        } else {
            medalView.showMedal(show: false)
        }
    }
    
    @IBAction func btnPushButton(button: PushButtonView) {
        if button.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        if isGraphViewShowing {
            counterViewTap(gesture: nil)
        }
        
        checkTotal()
    }
    
    @IBAction func counterViewTap(gesture: UITapGestureRecognizer?) {
        if (isGraphViewShowing) {
            UIView.transition(from: graphView, to: counterView, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            setupGraphDisplay()
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    func setupGraphDisplay() {
        
        let noOfDays:Int = 7
        
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter

        graphView.setNeedsDisplay()
        
        let max = graphView.graphPoints.max()!
        
        maxLabel.text = "\(max)"
        
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"

        let dateFormatter = DateFormatter()
        let calendar = NSCalendar.current
        let componentOptions:NSCalendar.Unit = .weekday
        let components = (calendar as NSCalendar).components(componentOptions, from: Date())
        var weekday = components.weekday
        
        let days = ["S", "S", "M", "T", "W", "T", "F"]
        
        //5 - set up the day name labels with correct day
        for i in (1...days.count).reversed() {
            if let labelView = graphView.viewWithTag(i) as? UILabel {
                if weekday == 7 {
                    weekday = 0
                }
                labelView.text = days[weekday!]
                weekday = weekday! - 1
                if weekday! < 0 {
                    weekday = days.count - 1
                }
            }
        }
    }
}

