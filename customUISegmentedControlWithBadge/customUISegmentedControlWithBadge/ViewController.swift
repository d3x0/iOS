//
//  ViewController.swift
//  customUISegmentedControlWithBadge
//
//  Created by Adrian Nugraha on 1/27/15.
//  Copyright (c) 2015 d3x0 Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var scMain: UISC_custom!

    @IBOutlet weak var scTest: UISC_custom!
    
    
    
    @IBAction func doSee(sender: AnyObject) {
        
        scTest.badgeForSegmentAtIndex(0, badge: "17")
        scTest.badgeForSegmentAtIndex(1, badge: "17")
        scTest.badgeForSegmentAtIndex(3, badge: "17")
        
        scMain.badgeForSegmentAtIndex(0, badge: "10")
        scMain.badgeForSegmentAtIndex(1, badge: "48")
        scMain.badgeForSegmentAtIndex(2, badge: "3")
        

        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "doUpdateBadge", userInfo: nil, repeats: true)
    }
    
    var iBadge: Int = 90
    
    func doUpdateBadge()
    {
        scTest.badgeForSegmentAtIndex(3, badge: String(iBadge))
        iBadge++
    }
    
    
    
    
    @IBAction func svMain(sender: AnyObject) {
        
        println(scMain.selectedSegmentIndex)
        
    }
    
    
    @IBAction func scTest(sender: AnyObject) {
        
        println(scTest.selectedSegmentIndex)
        
    }
    
    
    
    @IBAction func RemoveOne(sender: AnyObject) {
        
        scTest.removeBadgeAtSegmentIndex(1)
        scMain.badgeForSegmentAtIndex(2, badge: "17")
    }
    
}

